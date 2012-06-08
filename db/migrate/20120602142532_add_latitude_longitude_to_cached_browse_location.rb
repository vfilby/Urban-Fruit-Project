class AddLatitudeLongitudeToCachedBrowseLocation < ActiveRecord::Migration
  def change
    add_column :cached_browse_locations, :latitude, :float
    add_column :cached_browse_locations, :longitude, :float
  end
end
