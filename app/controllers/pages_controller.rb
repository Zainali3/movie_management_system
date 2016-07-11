class PagesController < ApplicationController
  def home
    @latest = Movie.latest_movie.first(4)
    @featured = Movie.featured_movie.first(4)
  end
end
