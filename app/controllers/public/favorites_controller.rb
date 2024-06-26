class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_event = PostEvent.find(params[:post_event_id])
    favorite = @post_event.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @post_event = PostEvent.find(params[:post_event_id])
    favorite = @post_event.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end
end
