class AddSourceIdToFruitCache < ActiveRecord::Migration
  def change
    add_column :fruit_caches, :source_id, :integer
    add_column :fruit_caches, :source_type, :string
    add_column :fruit_caches, :properties, :text
  end
end
