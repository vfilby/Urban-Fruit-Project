class Tag < ActiveRecord::Base
  include Tanker
  acts_as_tree
  
  serialize :meta, Hash
  has_and_belongs_to_many :fruit_caches
  
  tankit Rails.configuration.indextank_index do
    indexes :tag
  end
end
