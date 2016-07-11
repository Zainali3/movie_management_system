class AddMovieToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :movie, index: true, foreign_key: true
  end
end
