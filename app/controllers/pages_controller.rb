class PagesController < ApplicationController

  def home
    @latest = Movie.latest_movie.first(4)
    @featured = Movie.featured_movie.latest_movie.first(4)
    @top_rated = Movie.movie_order_by_rating.latest_movie.first(4)
  end

end
