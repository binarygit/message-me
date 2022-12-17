class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_or_reject_for Room.find(params[:id])
    stream_from 'room'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
