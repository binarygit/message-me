class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :room

  validates :description, presence: true
end
