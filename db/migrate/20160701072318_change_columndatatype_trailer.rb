class ChangeColumndatatypeTrailer < ActiveRecord::Migration
  def change
    change_column :movies, :trailer, :text
  end
end
