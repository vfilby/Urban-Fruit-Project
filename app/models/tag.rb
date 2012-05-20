class Tag < ActiveRecord::Base
  include Tanker
  acts_as_tree
  
  serialize :meta, Hash
  attr_accessor :meta_edit
  before_save :handle_meta_edit, :if => lambda {|t| t.meta_edit.present? }
  
  has_and_belongs_to_many :fruit_caches
  
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes
  
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
    parts = tagIdString.split( "," ).map(&:strip).reject(&:empty?)
    tagIds = []
    parts.each do |part|
      tag_id = Tag.process_tag_id part
      tagIds << tag_id
    end
    
    tagIds
  end
  
  def self.process_tag_id( tag_string )
    begin  
      id = Integer tag_string
      return id
    rescue
      tag = Tag.new( :tag => tag_string.tr( "'", "" ) )
      tag.save
      return tag.id
    end
  end
  
  protected
  def handle_meta_edit
    # You may want to perform eval in your validations instead of in a 
    # before_save callback, so that you can show errors on your form.
    debugger
    begin
      self.meta = eval(meta_edit)
    rescue SyntaxError => e
      self.meta = meta_edit
    end
  end
end
