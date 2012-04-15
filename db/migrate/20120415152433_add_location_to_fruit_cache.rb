class AddLocationToFruitCache < ActiveRecord::Migration
  def change
    add_column :fruit_caches, :location, :string
  end
end
