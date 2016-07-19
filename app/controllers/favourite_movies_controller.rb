class FavouriteMoviesController < ApplicationController

  before_action :get_movie
  before_action :favourite_movie_already_exist, only: [:create]

  def create
      if !favourite_movie_already_exist
        @favourite = @movie.favourite_movies.new
        @favourite.user = current_user
        @favourite.save
      end

  end

  private

    def get_movie
      @movie = Movie.find(params[:movie_id])
    end

    def favourite_movie_already_exist
      FavouriteMovie.check_already_added?(params[:movie_id], current_user.id)
    end
end
