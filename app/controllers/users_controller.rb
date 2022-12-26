class UsersController < ApplicationController
  def index
    @online_users = User.online
    @offline_users = User.offline
  end
end
