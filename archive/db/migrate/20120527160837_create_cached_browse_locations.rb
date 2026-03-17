class CreateCachedBrowseLocations < ActiveRecord::Migration
  def change
    create_table :cached_browse_locations, :id => false do |t|
      t.primary_key :id
      t.string :name, :null => false
      t.integer :parent_id
      
      t.timestamps
    end
  end
end
