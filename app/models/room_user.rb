class RoomUser < ActiveRecord::Base
  def self.in(room_id,user_id)
    data = RoomUser.where(room_id:room_id, user_id: user_id).take
    if data.nil?
      new_data = {room_id:room_id, user_id: user_id}
      RoomUser.create(new_data)
    end
  end
  def self.ping(room_id,user_id)
    data = RoomUser.where(room_id:room_id, user_id: user_id).take
    if data
      data.updated_at = Time.now
      data.save!
      true
    else
      false
    end
  end
  def self.quit(room_id,user_id)
    data = RoomUser.where(room_id:room_id, user_id: user_id).take
    data.destroy if data
    room = Room.find room_id
    room.destroy if room.owner_id == user_id
  end
end
