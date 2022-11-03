class LoginInvitation < ApplicationRecord
  validates :email, :unique_hash, presence: true
end
