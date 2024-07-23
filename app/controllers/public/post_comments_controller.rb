# frozen_string_literal: true

class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: %i[destroy]

  def create
    post_event = PostEvent.find(params[:post_event_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_event_id = post_event.id
    return redirect_to post_event_path(post_event), notice: "コメントを投稿しました！" if comment.save
    redirect_to request.referer
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_event_path(params[:post_event_id])
  end

  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
  def is_matching_login_user
    post_comment = PostComment.find(params[:id])
    user = User.find(post_comment.user_id)
    unless user.id == current_user.id
      redirect_to post_events_path
    end
  end
end
