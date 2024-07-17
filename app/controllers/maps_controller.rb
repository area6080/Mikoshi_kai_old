# frozen_string_literal: true

class MapsController < ApplicationController
  def show
    @post_event = PostEvent.new
  end
end
