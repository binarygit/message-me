class LoginInvitationMailer < ApplicationMailer

  def login_invitation(invitation)
    @invitation = invitation
    mail(to: @invitation.email, subject: "[Message me!] Login via link")
  end
end
