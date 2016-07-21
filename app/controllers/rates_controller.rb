class RatesController < ApplicationController
  before_action :set_rating, only: [:update, :destroy]
  before_action :set_movie

  def create
    @rating = @movie.rates.new(rating_params)
    @rating.user_id = current_user.id
    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rating, notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rate, notice: 'Rating was successfully updated.' }
        format.json { render json: { rating: @rating, average: @movie.get_average } }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_rating
      @rating = Rate.find(params[:id])
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def rating_params
      params.require(:rate).permit(:rating)
    end
end
