class LoginInvitationsController < ApplicationController
  def create
    @invitation = LoginInvitation.new
    hash = SecureRandom.urlsafe_base64
    @invitation.email = params[:email]
    @invitation.unique_hash = hash
    if @invitation.save
      LoginInvitationMailer.login_invitation(@invitation).deliver_later
      flash[:success] = "Login link has been sent to #{params[:email]}"
    else
      flash[:danger] = "Sorry, something went wrong!"
    end

    redirect_to root_path
  end

  def verify
    @invitation = LoginInvitation.find_by(hash: params[:hash])
    @verified = true if invitation
  end
end
