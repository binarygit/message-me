class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_or_reject_for Room.find(params[:id])
    stream_from 'room'
  end

  def unsubscribed
    stop_all_streams
  end

  private

  def html
    #ApplicationController.render(partial: "users/user", locals: { user: current_user })
    ApplicationController.render(UserComponent.new(user: current_user))
  end
end
