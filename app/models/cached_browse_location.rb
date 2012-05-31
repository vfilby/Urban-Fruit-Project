class CachedBrowseLocation < ActiveRecord::Base
  require 'geonames'
  acts_as_tree
  
  attr_accessible :id
  attr_accessible :name
  attr_accessible :parent_id
    
  validates_presence_of :name
  validates_presence_of :id
  
end
