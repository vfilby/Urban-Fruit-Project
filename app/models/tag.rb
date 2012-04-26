class Tag < ActiveRecord::Base
  acts_as_tree
  
  serialize :meta, Hash
  has_and_belongs_to_many :fruit_caches
end
