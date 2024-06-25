class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @groups = Group.preload(:user)
  end

  def show
    @group = Group.find(params[:id])
  end
  
  def destroy
    Group.find(params[:id]).destroy
    redirect_to admin_groups_path
  end
end
