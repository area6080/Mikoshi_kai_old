class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post_event = PostEvent.find(params[:post_event_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_event_id = post_event.id
    comment.save
    redirect_to post_event_path(post_event)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_event_path(params[:post_event_id])
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
end
