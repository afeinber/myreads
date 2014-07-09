class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @follow = Follow.new
    @follow.user = current_user
    @follow.followee = User.find(params[:user_id])

    @follow.save
    redirect_to :back
  end

  def destroy
    @follow = current_user.follows.find_by(followee_id: params[:followee_id])
    @follow.destroy
    redirect_to :back
  end
end
