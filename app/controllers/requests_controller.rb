class RequestsController < ApplicationController

  def create
    @request = Request.new
    @request.user = current_user
    @request.recipient = User.find(params[:recipient_id])

    @request.save
    redirect_to :back
  end

  def destroy
    @request = Request.find_by(user_id: params[:user_id], recipient_id: params[:recipient_id])
    @request.destroy
    redirect_to :back
  end

  def index
    if current_user.inverse_recommendations.count > 0
      @books = current_user.inverse_recommendations.map(&:book).
        zip(current_user.inverse_recommendations.map(&:user)).to_h
    end
    @users = current_user.inverse_requests.map(&:user)

  end
end
