class Public::ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    participation = @group.participations.new(user_id: current_user.id)
    participation.save
    redirect_to request.referer
  end

  def destroy
    @group = Group.find(params[:group_id])
    participation = @group.participations.find_by(user_id: current_user.id)
    participation.destroy
    redirect_to request.referer
  end
end
