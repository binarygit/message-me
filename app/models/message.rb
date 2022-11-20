class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :room

  validates :description, presence: true

  after_create_commit do
    partial = {partial: "messages/message", locals: { message: self }}
    cable_ready[RoomsChannel].insert_adjacent_html(selector: "#anchor", html: render(partial), position: "beforebegin").broadcast_to(self.room)
  end
end
