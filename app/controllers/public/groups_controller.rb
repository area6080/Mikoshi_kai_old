# frozen_string_literal: true

class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: %i[edit update destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])

    join = Participation.where(group_id: @group.id).pluck(:user_id)
    @members = User.new
    @members = User.where(id: join)
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    return redirect_to groups_path if @group.save
    render :new
  end

  def edit
  end

  def update
    return redirect_to groups_path if @group.update(group_params)
    render :edit
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path
  end

  private
  
  def group_params
    params.require(:group).permit(:name)
  end

  def is_matching_login_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
