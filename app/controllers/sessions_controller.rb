class SessionsController < ApplicationController
  def create
    @invitation = LoginInvitation.find(params[:invitation_id])
    @user = User.find_or_create_by(email: @invitation.email)
    @invitation.destroy
    session[:user_id] = @user.id
    
    flash[:success] = "You are successfully logged in."
    redirect_to messages_path
  end
end
