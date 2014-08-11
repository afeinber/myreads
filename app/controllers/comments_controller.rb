class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]


  def create
    @comment = Comment.make_comment(comment_params, current_user, params[:book_id])
    flash[:alert] = @comment.errors.full_messages.join(', ') unless @comment.save
    redirect_to :back
  end


  def destroy
    current_user.comments.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
