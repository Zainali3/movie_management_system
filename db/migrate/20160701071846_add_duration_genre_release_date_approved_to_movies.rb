class AddDurationGenreReleaseDateApprovedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :duration, :integer
    add_column :movies, :genre, :string, limit: 50
    add_column :movies, :release_date, :date
    add_column :movies, :approved, :boolean
  end
end
