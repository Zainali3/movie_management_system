class FavouriteMovie < ActiveRecord::Base

  paginates_per 4

  belongs_to :user
  belongs_to :movie

  def self.check_already_added?(movie_id,user_id)
    FavouriteMovie.exists?(movie_id: movie_id, user_id: user_id)
  end

end
