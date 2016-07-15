class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :find_movie
  before_action :authenticate_user!

  def new
    @review = Review.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user_id = current_user.id
    @review.save
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review.movie, notice: 'Review was successfully updated.' }
        format.js
      else
        format.html { redirect_to @review.movie, notice: 'Review could not be updated' }
        format.js
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_params
      params.require(:review).permit(:review)
    end
end
