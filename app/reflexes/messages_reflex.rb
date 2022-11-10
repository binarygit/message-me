# frozen_string_literal: true

class MessagesReflex < ApplicationReflex
  before_reflex :find_user

  def create
    @new_message = @user.messages.build(message_params)
    @new_message.save
    partial = {partial: "message", locals: { message: @new_message }}
    if @new_message.persisted?
      cable_ready.insert_adjacent_html(selector: "#anchor", html: render(partial), position: "beforebegin").broadcast
    end
    morph :nothing
  end

  private

  def find_user
    @user = User.find(session[:user_id])
  end

  def message_params
    params.require(:message).permit(:description)
  end
end
