class PagesController < ApplicationController

  def home
    movie = Movie.includes(:posters)
    @latest = movie.latest_movie.approved_movie.first(4)
    @featured = movie.featured_movie.latest_movie.approved_movie.first(4)
    @top_rated = movie.movie_order_by_rating.latest_movie.approved_movie.first(4)
  end

end
