class LoginInvitation < ApplicationRecord
  after_create_commit :send_mail
  validates :email, :unique_hash, presence: true

  private

  def send_mail
    LoginInvitationMailer.login_invitation(self).deliver_later
  end
end
