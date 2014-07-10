class RecommendationsController < ApplicationController

  def create
    @recommendation = Recommendation.new
    @recommendation.user = current_user
    @recommendation.recipient = User.find(params[:recipient])
    @recommendation.book = Book.find(params[:book])

    @recommendation.save

    redirect_to :back
  end
end
