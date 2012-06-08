class CachedBrowseLocation < ActiveRecord::Base
  require 'geonames'
  acts_as_tree
  
  attr_accessible :id
  attr_accessible :name
  attr_accessible :parent_id, :latitude, :longitude
    
  validates_presence_of :name
  validates_presence_of :id
  
  has_and_belongs_to_many :fruit_caches, :class_name => 'FruitCache', :before_add => :validate_cache
  
  def validate_cache(cache)
    raise ActiveRecord::Rollback if self.fruit_caches.include? cache
  end
  
end
