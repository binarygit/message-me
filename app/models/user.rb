class User < ApplicationRecord
  has_many :messages, foreign_key: :author_id
  validates :email, presence: true
end
