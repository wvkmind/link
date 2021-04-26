class RoomJob < ActiveJob::Base
  queue_as :room_list

  def perform(room_id)
    RoomUser.where(room_id: room_id).each do |room_user|
      if room_user.updated_at < Time.now - 1.minutes
        room_user.destroy
      end
    end
    room = Room.find room_id
    return if room.nil?
    if RoomUser.where(user_id: room.owner_id, room_id: room_id).take.nil?
      room.destroy
    else
      RoomJob.set(wait: 1.minutes).perform_later(room_id)
    end
  end
end
