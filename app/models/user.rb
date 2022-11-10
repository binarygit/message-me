class User < ApplicationRecord
  has_many :messages, foreign_key: :author_id, dependent: :destroy
  validates :email, presence: true
end
