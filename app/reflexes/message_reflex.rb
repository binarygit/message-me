# frozen_string_literal: true

class MessageReflex < ApplicationReflex
  def load_more_messages(offset)
    room = Room.find element.dataset[:room_id]
    messages = room.messages.order(created_at: :desc).offset(offset).limit(10).reverse
    cable_ready.insert_adjacent_html(selector: "#load-more", html: render(partial: "messages/message", collection: messages), position: "afterend")
    morph :nothing
  end
end
