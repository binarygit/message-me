class LoginInvitationsController < ApplicationController
  def create
    @invitation = LoginInvitation.new
    hash = SecureRandom.urlsafe_base64
    @invitation.email = params[:email]
    @invitation.unique_hash = hash
    @invitation.save
    flash[:success] = "Login link has been sent to #{params[:email]}"
    redirect_to root_path
  end

  def verify
    @invitation = LoginInvitation.find_by(hash: params[:hash])
    @verified = true if invitation
  end
end
