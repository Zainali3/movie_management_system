class MoviesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.search_movies(params)
    if @movies.present?
      @movies = @movies.page(params[:page]).per(Movie::PER_PAGE)
    else
      flash[:notice] = "No movies found"
    end
  end

  def show
      @review = @movie.reviews.build
      @rating = @movie.get_ratings(current_user) if user_signed_in?
  end

  def new
    @movie = Movie.new
  end

  def edit
    @selected_movies = @movie.actor_ids
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :trailer, :genre, :description, :featured, :approved, :release_date, :duration, actor_ids: [],
        posters_attributes: [:id, :image, :_destroy])
    end

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
