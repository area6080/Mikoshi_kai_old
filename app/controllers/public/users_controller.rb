class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @post_events = PostEvent.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_user_params)
      flash[:notice] = "ユーザー情報を更新しました!"
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    if admin_signed_in?
      redirect_to admin_users_path
    else
      redirect_to new_user_registration_path
    end
  end
  
    private

  def update_user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  # 他人のユーザー編集画面に入るのを無効化
end
