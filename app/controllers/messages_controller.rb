class MessagesController < ApplicationController
  def create
    message = current_user.messages.build(description: params[:message][:description])
    room = Room.find(params[:message][:room_id])
    room.messages << message
  end
end
