class RemoveNameFromFruitCache < ActiveRecord::Migration
  def up
    add_column :fruit_caches, :primary_tag_id, :integer
  end

  def down
    remove_column :fruit_caches, :primary_tag_id
  end
end
