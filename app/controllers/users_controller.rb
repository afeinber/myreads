class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.search(params[:search_user])
  end

  def show
    @user = User.find(params[:id])
    @user_books = @user.listed_books.order(:order_index).to_a.map(&:book)
  end

end
