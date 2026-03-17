class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :caption
      t.integer :fruit_cache_id

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
