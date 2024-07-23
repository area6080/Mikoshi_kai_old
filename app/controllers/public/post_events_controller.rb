# frozen_string_literal: true

class Public::PostEventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :is_matching_login_user, only: %i[edit update destroy]

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
    # @post_comments = PostComment.preload(:user).order(created_at: :desc)
    # @post_comments = PostComment.eager_load(:user).order('created_at DESC') has_oneの場合
    # 上記二行で制御せずreverse_eachを使用する
  end

  def create
    @post_event = PostEvent.new(post_event_params)
    @post_event.user_id = current_user.id

    if @post_event.save
      @post_event.create_tags
      flash[:notice] = "イベントを投稿しました!"
      redirect_to post_event_path(@post_event.id)
    else
      redirect_to request.referer
    end
  end

  def edit
  end
  # is_matching_login_userで定義しているので省略できる

  def update
    if @post_event.update(update_post_event_params)
      @post_event.create_tags
      flash[:notice] = "イベント内容を更新しました!"
      redirect_to post_event_path(@post_event.id)
    else
      render :edit
    end
  end

  def destroy
    @post_event.destroy
    redirect_to user_path(current_user)
  end


  private
  
  def post_event_params
    params.require(:post_event).permit(:title, :caption, :event_date, :address, :latitude, :longitude, :user_id, :image)
  end

  def update_post_event_params
    params.require(:post_event).permit(:title, :caption, :event_date, :address, :latitude, :longitude, :image)
  end

  def is_matching_login_user
    @post_event = PostEvent.find(params[:id])
    @user = User.find(@post_event.user_id)
    unless @user.id == current_user.id
      redirect_to post_events_path
    end
  end
  # 他人の投稿編集画面に入るのを無効化
end
