class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :room

  validates :description, presence: true

  after_create do
    cable_ready[RoomsChannel].insert_adjacent_html(selector: "#anchor", html: render(MessageComponent.new(message: self)), position: "beforebegin").broadcast_to(self.room)

    # Notify that a new message has been created
    selector = "#{ dom_id self.room, :button }.operative"
    cable_ready['room'].text_content(selector: selector, text: "#{self.room.name}*").
      remove_css_class(selector: selector, name: "btn-info").
      add_css_class(selector: selector, name: "btn-warning").add_css_class(selector: selector, name: "pulsating").broadcast
  end
end
