class CreateFruitCaches < ActiveRecord::Migration
  def self.up
    create_table :fruit_caches do |t|
      t.string :Name
      t.string :Description
      t.integer :Rating
      t.float :Latitude
      t.float :Longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :fruit_caches
  end
end
