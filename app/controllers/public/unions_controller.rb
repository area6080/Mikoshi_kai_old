class Public::UnionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post_event = PostEvent.find(params[:post_event_id])
    join = Union.where(post_event_id: @post_event.id).pluck(:user_id)
    @members = User.new
    @members = User.where(id: join)
  end

  def create
    @post_event = PostEvent.find(params[:post_event_id])
    union = @post_event.unions.new(user_id: current_user.id)
    union.save
    redirect_to request.referer
  end

  def destroy
    @post_event = PostEvent.find(params[:post_event_id])
    union = @post_event.unions.find_by(user_id: current_user.id)
    union.destroy
    redirect_to request.referer
  end
end
