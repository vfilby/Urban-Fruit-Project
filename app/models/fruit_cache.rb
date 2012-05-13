class FruitCache < ActiveRecord::Base
  include Tanker
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :log_entries
  has_many :images, :dependent => :destroy
  belongs_to :primary_tag, :class_name => "Tag", :foreign_key => "primary_tag_id"
  has_and_belongs_to_many :tags
  
  accepts_nested_attributes_for :images, :allow_destroy => true#, :reject_if => lambda { |t| t('trip_image').nil? }
    
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes
  
  # Ruby Geocoder
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.location = "#{geo.city}, #{geo.state_code}, #{geo.country_code}"
    end
  end
  after_validation :reverse_geocode
  
  # Gmaps4rails
  acts_as_gmappable :process_geocoding => false
  
  validates_presence_of :name, :on => :create, :message => "Please provide a name"
  validates_presence_of :description, :on => :create, :message => "Please provide a description"
  validates_presence_of :latitude, :on => :create, :message => "Latitude required"
  validates_presence_of :longitude, :on => :create, :message => "Longitude required"
  
  #
  # Index descriptions & functions
  #
  tankit Rails.configuration.indextank_index do
    indexes :name
    indexes :description
    variables do 
      {
          0 => latitude,
          1 => longitude
      }
    end

    # You may defined some server-side functions that can be
    # referenced in your queries. They're always referenced by
    # their integer key:
    functions do
      {
        1 => '-km(query.var[0], query.var[1], doc.var[0], doc.var[1])',
        2 => 'km(query.var[0], query.var[1], doc.var[0], doc.var[1])',
        3 => '-age',
        4 => 'age',
      }
    end
  end
  
  # Note! Will Paginate pagination, thanks mislav!
  def self.per_page
    10
  end
  
  # GMaps4Rails
  #
  def short_description( length = 55 )
    if description.length > length
      return description[0..length] + "..."
    else 
      return description
    end
  end
end
