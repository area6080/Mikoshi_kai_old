class MapsController < ApplicationController
  def show
    @post_event = PostEvent.new
  end
end
