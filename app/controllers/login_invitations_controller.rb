class LoginInvitationsController < ApplicationController
  skip_before_action :require_login

  def create
    @invitation = LoginInvitation.new
    hash = SecureRandom.urlsafe_base64
    @invitation.email = params[:email]
    @invitation.unique_hash = hash
    if @invitation.save
      flash[:success] = "Login link has been sent to #{params[:email]}"
    else
      flash[:danger] = "Sorry, something went wrong!"
    end

    redirect_to root_path
  end

  def verify
    @invitation = LoginInvitation.find_by(unique_hash: params[:hash])
  end
end
