class CreateFruitCaches < ActiveRecord::Migration
  def self.up
    create_table :fruit_caches do |t|
      t.string :name
      t.string :description
      t.integer :rating
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :fruit_caches
  end
end
