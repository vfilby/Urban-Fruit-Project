class Image < ActiveRecord::Base
  belongs_to :fruit_cache
  
  has_attached_file :photo, 
    :styles => { 
      :thumbnail_crop => "60x60#",
      :halfwidth => "460",
      :halfwidth_crop => "460x345#",
      :fullwidth => "940",
      :fullwidth_crop => "940x550#"
    },
    :storage => :s3,
    :bucket => ENV['PAPERCLIP_S3_BUCKET'],
    :path => 'paperclip_assets/:attachment/:id/:style/:filename',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
end
