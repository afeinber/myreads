class RequestsController < ApplicationController

  def create
    @request = Request.new
    @request.user = current_user
    @request.recipient = User.find(params[:user_id])

    @request.save
    redirect_to :back
  end

  def destroy
    @request = current_user.requests.find_by(recipient_id: params[:id])
    @request.destroy
    redirect_to :back
  end

  def index
    @users = current_user.inverse_requests.map(&:user)

  end
end
