class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    @invitation = LoginInvitation.find(params[:invitation_id])
    @user = User.find_or_create_by(email: @invitation.email)
    @invitation.delete
    cookies.encrypted[:user_id] = @user.id
    
    flash[:success] = "You are successfully logged in."
    # TODO redirect to the last room the user was in
    # or redirect to the first room
    room = Room.first
    redirect_to room
  end

  def destroy
    cookies.delete :user_id
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
end
