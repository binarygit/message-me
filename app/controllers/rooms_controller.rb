class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.order(created_at: :desc).limit(10).reverse
  end
end
