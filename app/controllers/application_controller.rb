class ApplicationController < ActionController::Base
  before_action :require_login
  include CableReady::Broadcaster

  private

  def logged_in?
    !session[:user_id].nil?
  end

  def require_login
    unless logged_in?
      flash[:danger] = "You must be logged in to access this section."
      redirect_to root_url
    end
  end
end
