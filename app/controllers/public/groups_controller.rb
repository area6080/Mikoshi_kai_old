class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
