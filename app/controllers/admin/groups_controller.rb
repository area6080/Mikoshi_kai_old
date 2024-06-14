class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end
end
