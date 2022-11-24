class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :room

  validates :description, presence: true

  after_create_commit do
    partial = {partial: "messages/message", locals: { message: self }}
    cable_ready[RoomsChannel].insert_adjacent_html(selector: "#anchor", html: render(partial), position: "beforebegin").broadcast_to(self.room)
    # TODO Notify user when a new messages pops up in another room
    #cable_ready[RoomsChannel].text_content(selector: "#{ dom_id self.room, :button }.operative", text: "Hello World!").broadcast_to(self.room)
  end
end
