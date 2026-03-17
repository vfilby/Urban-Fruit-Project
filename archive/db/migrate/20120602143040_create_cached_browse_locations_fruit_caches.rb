class CreateCachedBrowseLocationsFruitCaches < ActiveRecord::Migration
  def change
    create_table :cached_browse_locations_fruit_caches, :id => false do |t|

      t.references :cached_browse_location, :fruit_cache
    end
    
    add_index :cached_browse_locations_fruit_caches, [:cached_browse_location_id, :fruit_cache_id], :name => "keys_index"
  end
end
