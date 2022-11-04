class LoginInvitationMailer < ApplicationMailer

  def login_invitation(id)
    @invitation = LoginInvitation.find(id)
    mail(to: @invitation.email, subject: "[Message me!] Login via link")
  end
end
