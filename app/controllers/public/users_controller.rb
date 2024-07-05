class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @post_events = PostEvent.where(user_id: @user.id)

    favs = Favorite.where(user_id: @user.id).pluck(:post_event_id)
    @fav_events = PostEvent.new
    # nil回避のため入れた
    @fav_events = PostEvent.where(id: favs)
    # Railsのwhereメソッドでは整数の配列を渡すことはできない→id: favs
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
    if user.guest_user?
      flash[:notice] = "ゲスト機能のご利用ありがとうございました。"
    else
      flash[:notice] = "またのご利用をお待ちしております。"
    end
    user.destroy
    redirect_to new_user_registration_path
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集は行えません。"
    end
  end
end
