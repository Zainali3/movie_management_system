class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = params[:type] =='featured' ? Movie.featured_movie : Movie.latest_movie
    @movies = @movies.page(params[:page])
  end

  def show
    @review = @movie.reviews.build
  end

  def new
    @movie = Movie.new
  end

  def edit
    @selected_movies = @movie.actor_ids
  end

  def create
    @movie = Movie.new(movie_params.merge({genre: params[:movie][:genre].join(' ')}))

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
      if @movie.update(movie_params.merge({genre: params[:movie][:genre].join(' ')}))
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
      params.require(:movie).permit(:title, :trailer, :description, :featured, :approved, :release_date, :duration, actor_ids: [],
        posters_attributes: [:id, :image, :_destroy])
    end
end
