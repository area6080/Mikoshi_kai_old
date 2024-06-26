class Admin::PostEventsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_events = PostEvent.all
  end

  def show
    @post_event = PostEvent.find(params[:id])
  end

  def destroy
    PostEvent.find(params[:id]).destroy
    redirect_to admin_post_events_path
  end
end
