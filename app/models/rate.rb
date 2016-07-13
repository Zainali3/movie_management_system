class Rate < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  def self.movie_avg_rating(movie)
    ratings = Rate.where(movie_id: movie)
    ratings.present? ? ratings.average(:rating).round(2) : 0
  end

  def self.rating(movie, user, rating_params)
    prev_rating = movie.rates.where(user_id: user).first
    if prev_rating.nil?
      rating = movie.rates.new(rating_params)
      rating.user_id = user
      rating.save
    else
      save_rating = movie.rates.where(user_id: user).first.update(rating: rating_params[:rating])
    end
  end
end
