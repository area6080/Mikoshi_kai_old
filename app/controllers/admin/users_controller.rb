class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_events = @user.post_events
  end
end
