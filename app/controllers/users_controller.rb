class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.search(params[:search_user])
  end

  def show
    @user_books = current_user.books
  end

end
