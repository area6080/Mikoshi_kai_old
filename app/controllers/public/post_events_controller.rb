class Public::PostEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    respond_to do |format|
      format.html do
        @post_events = PostEvent.all
      end
      format.json do
        @post_events = PostEvent.all
      end
    end
  end
  
  def new
    @post_event = PostEvent.new
  end

  def show
    @post_event = PostEvent.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @post_event = PostEvent.new(post_event_params)
    @post_event.user_id = current_user.id
    if @post_event.save
      flash[:notice] = "イベントを投稿しました!"
      redirect_to post_event_path(@post_event.id)
    else
      redirect_to post_events_path, flash: { error: @post_event.errors.full_messages }
    end
  end

  def edit
    @post_event = PostEvent.find(params[:id])
    @user = User.find(@post_event.user_id)
  end

  def update
    @post_event = PostEvent.find(params[:id])
    if @post_event.update(update_post_event_params)
      flash[:notice] = "イベント内容を更新しました!"
      redirect_to post_event_path(@post_event.id)
    else
      render :edit
    end
  end

  def destroy
    post_event = PostEvent.find(params[:id])
    post_event.destroy
    if admin_signed_in?
      redirect_to admin_post_events_path
    else
      redirect_to post_events_path
    end
  end
  
  
  private

  def post_event_params
    params.require(:post_event).permit(:title, :caption, :event_date, :address, :latitude, :longitude, :user_id, :image)
  end

  def update_post_event_params
    params.require(:post_event).permit(:title, :caption, :event_date, :address, :latitude, :longitude, :image)
  end
  
  # def is_matching_login_user
  #   post_event = post_event.find(params[:id])
  #   user = User.find(post_event.user_id)
  #   unless user.id == current_user.id
  #     redirect_to post_events_path
  #   end
  # end
end
