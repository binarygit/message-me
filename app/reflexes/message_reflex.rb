# frozen_string_literal: true

class MessageReflex < ApplicationReflex
  def load_more_messages(offset)
    room = Room.find element.dataset[:room_id]
    messages = room.messages.order(created_at: :desc).offset(offset).limit(10).reverse
    if messages.any?
      cable_ready.insert_adjacent_html(selector: "#load-more", html: render(LoadedMessageComponent.with_collection(messages)), position: "afterend")
    else
      cable_ready.prepend(selector: "#flash-container", html: render(partial: "layouts/flash", locals: { message_type: 'warning', message: "No more messages!"}))
    end
    morph :nothing
  end
end
