class RatesController < ApplicationController
  before_action :find_movie
  before_action :rating_params

  def create
    Rate.rating(@movie, current_user.id,rating_params)
    redirect_to movie_path(@movie)
  end

  def new
    @rating = Rate.new
  end

  private

    def set_rating
      @rating = Rate.find(params[:id])
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end

    def rating_params
      params.require(:rate).permit(:rating)
    end
end
