class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_or_reject_for Room.find(params[:id])
    stream_from 'room'
    ActionCable.server.pubsub.redis_connection_for_subscriptions.sadd "online", current_user.id
    cable_ready['room'].remove(selector: dom_id(current_user))
      .append(selector: "#online-users", html: html).broadcast
  end

  def unsubscribed
    stop_all_streams
    ActionCable.server.pubsub.redis_connection_for_subscriptions.srem "online", current_user.id
    cable_ready['room'].remove(selector: dom_id(current_user)).
      append(selector: "#offline-users", html: html).broadcast
  end

  private

  def html
    ApplicationController.render(partial: "users/user", locals: { user: current_user })
  end
end
