class Public::UsersController < ApplicationController
    # before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def show
    @user = current_user
    @post_events = @user.post_events
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_user_params)
      flash[:notice] = "You have updated successfully."
      redirect_to mypage_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to new_user_registration_path
  end
  
    private

  def update_user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

  # def is_matching_login_user
  #   book = Book.find(params[:id])
  #   user = User.find(book.user_id)
  #   unless user.id == current_user.id
  #     redirect_to books_path
  #   end
  # end