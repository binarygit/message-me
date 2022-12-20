class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_or_reject_for Room.find(params[:id])
    stream_from 'room'
  end

  def unsubscribed
    stop_all_streams
  end
end
