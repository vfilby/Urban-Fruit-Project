class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
      t.integer :parent_id
      t.string :meta

      t.timestamps
    end
    
    create_table :fruit_caches_tags, :id => false do |t|
      t.references :fruit_cache, :tag
    end
    
    add_index :fruit_caches_tags, [:fruit_cache_id, :tag_id]
  end
end
