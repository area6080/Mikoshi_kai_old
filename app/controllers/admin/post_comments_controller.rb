# frozen_string_literal: true

class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.preload(:post_event)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_comments_path
  end
end
