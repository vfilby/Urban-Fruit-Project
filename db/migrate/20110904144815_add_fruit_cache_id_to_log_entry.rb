class AddFruitCacheIdToLogEntry < ActiveRecord::Migration
  def self.up
    add_column :log_entries, :fruit_cache_id, :integer
  end

  def self.down
    remove_column :log_entries, :fruit_cache_id
  end
end
