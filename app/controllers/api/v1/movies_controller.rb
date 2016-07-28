module Api
  module V1
    class MoviesController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      respond_to :json

      before_action :authenticate_request

      def index
        if (params[:title] || params[:genre] || params[:actors] || params[:start_date])
          respond_with Movie.search_movies(params)
        else
          @movies = Movie.all
          @movies = @movies.page(params[:page]).per Movie::PER_PAGE
          respond_with @movies
        end
      end

      def show
        @movie = Movie.find(params[:id])
        respond_with @movie.searched_movie(request.env['HTTP_HOST'])
      end

      def not_found
        render json: "Record Not Found", status: 404
      end

      def authenticate_request
        if request && request.headers && request.headers['Authorization']
          return if request.headers['Authorization'] == User::TOKEN
        end
        head :unauthorized
      end
    end
  end
end
