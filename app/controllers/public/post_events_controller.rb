class Public::PostEventsController < ApplicationController
  def new
    @post_event = PostEvent.new
  end

  def show
    @post_event = PostEvent.find(params[:id])
  end

  def create
    @post_event = PostEvent.new(post_event_params)
    @post_event.user_id = current_user.id
    if @post_event.save
      # flash[:notice] = "You have created post_event successfully."
      redirect_to post_event_path(@post_event.id)
    else
      redirect_to post_events_path, flash: { error: @post_event.errors.full_messages }
    end
  end

  def edit
    @post_event = post_event.find(params[:id])
    @user = User.find(@post_event.user_id)
  end

  def update
    @post_event = post_event.find(params[:id])
    if @post_event.update(update_post_event_params)
      flash[:notice] = "You have updated post_event successfully."
      redirect_to post_event_path(@post_event.id)
    else
      render :edit
    end
  end

  def destroy
    post_event = post_event.find(params[:id])
    post_event.destroy
    redirect_to post_events_path
  end
  
  
  private

  def post_event_params
    params.require(:post_event).permit(:title, :caption, :event_date, :address, :latitude, :longitude, :user_id)
  end

  def update_post_event_params
    params.require(:post_event).permit(:title, :caption, :event_date, :address, :latitude, :longitude)
  end
  
  def is_matching_login_user
    post_event = post_event.find(params[:id])
    user = User.find(post_event.user_id)
    unless user.id == current_user.id
      redirect_to post_events_path
    end
  end
end
