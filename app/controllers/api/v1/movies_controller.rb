module Api
  module V1
    class MoviesController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      respond_to :json

      def index
        if (params[:title] || params[:genre] || params[:actors] || params[:release_date])
          respond_with Movie.search_movies(params)
        else
          respond_with Movie.all
        end
      end

      def show
        @movie = Movie.find(params[:id])
        respond_with @movie.searched_movie
      end

      def not_found
        render json: "Record Not Found", status: 404
      end
    end
  end
end
