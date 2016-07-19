class UsersController < ApplicationController

  def show
    @user = current_user
    @favourite_movies = @user.favourite_movies.page(params[:page])
  end

end
