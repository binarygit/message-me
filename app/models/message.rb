class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
  validates :description, presence: true
end
