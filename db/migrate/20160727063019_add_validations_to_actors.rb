class AddValidationsToActors < ActiveRecord::Migration
  def change
    change_column :actors, :name, :string, null: false, limit: 40
  end
end
