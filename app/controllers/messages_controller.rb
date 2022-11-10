class MessagesController < ApplicationController
  def index
    @messages = Message.order(created_at: :asc).reverse_order
  end
end
