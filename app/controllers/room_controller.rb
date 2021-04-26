class RoomController < ApplicationController
  def create
    data = {
      password: params[:room_password],
      name: params[:name],
      owner_id: @user.id,
      map_type: params[:map_type]
    }
    new_room = Room.new data
    if new_room.valid?
      new_room.save!
      #开启自动清理房间的任务
      RoomUser.in(new_room.id, @user.id)
      RoomJob.set(wait: 1.minutes).perform_later(new_room.id)
      render json: {code: 0, data: new_room.url}
    else
      render json: {code: 1, msg: '创建失败'}
    end
  end
  def index
    page = params[:page].to_i
    limit = params[:limit].to_i
    name = params[:name]
    rooms = Room.order(created_at: :desc).limit(limit).offset( (page-1)*limit )
    if name
      rooms = rooms.where(name: name)
    end
    data = rooms.map do |room|
      need_password = room.password == 'no_password'
      {
        room_id: room.id,
        name: room.name,
        need_password: need_password,
        map_type: room.map_type
      }
    end
    render json: {code: 0, data: data }
  end
  def join
    room_id = params[:room_id]
    room = if params[:room_password]
              Room.where(id:room_id,password: params[:room_password]).take
           else
             Room.where(id:room_id,password: 'no_password').take
           end
    if room.nil?
      render json: {code: 1, msg: '加入失败' }
    else
      RoomUser.in(room_id, @user.id)
      render json: {code: 0, data: room.url }
    end
  end

  def ping
    room_id = params[:room_id]
    if RoomUser.ping(room_id, @user.id)
      render json: {code: 0}
    else
      render json: {code: 1}
    end
  end

  def exit
    room_id = params[:room_id]
    RoomUser.quit(room_id, @user.id)
    render json: {code: 0}
  end

end
