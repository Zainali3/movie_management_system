class AddValidationsToMovies < ActiveRecord::Migration
  def up
    change_column :movies, :title, :string, null: false, limit: 35
    change_column :movies, :trailer, :text, null: false
    change_column :movies, :description, :text, null: false
    change_column :movies, :duration, :integer, null: false
    change_column :movies, :genre, :string, null: false, limit: 30
    change_column :movies, :release_date, :date, null: false
  end
  def down
    change_column :movies, :title, :string
    change_column :movies, :trailer, :text
    change_column :movies, :description, :text
    change_column :movies, :duration, :integer
    change_column :movies, :genre, :string
    change_column :movies, :release_date, :date
  end
end
