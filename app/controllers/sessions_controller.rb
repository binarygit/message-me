class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    @invitation = LoginInvitation.find(params[:invitation_id])
    @user = User.find_or_create_by(email: @invitation.email)
    @invitation.destroy
    session[:user_id] = @user.id
    
    flash[:success] = "You are successfully logged in."
    redirect_to messages_url
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
end
