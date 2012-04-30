class Tag < ActiveRecord::Base
  include Tanker
  acts_as_tree
  
  serialize :meta, Hash
  has_and_belongs_to_many :fruit_caches
  
  tankit Rails.configuration.indextank_index do
    indexes :tag
  end
  
  
  # This takes a comma separated string of Id's and
  # new values (strings) and converts to an array of
  # id's.  New values are first saved.
  #
  # Example Input: "1,5,43,'new-tag',12"
  def self.process_tag_ids( tagIdString )
    debugger
    parts = tagIdString.split( "," )
    tagIds = []
    parts.each do |part|
      begin  
        id = Integer part
        tagIds << id
      rescue
        tag = Tag.new( :tag => part.tr( "'", "" ) )
        tag.save
        tagIds << tag.id
      end
    end
    
    tagIds
  end
end
