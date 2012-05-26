module UrbanFruitProject
  module Entities
    class Tag < Grape::Entity
      expose :id
      expose :tag, :as => :text
      expose :meta
    end
    
    class Image < Grape::Entity
      expose :id
      expose :caption
      expose :photo_file_name, :as => :filename
      expose :photo_file_size, :as => :filesize
      expose(:url) { |model,options| model.photo.url  }
    end
    
    class Cache < Grape::Entity
      expose :id, :as => :cache_id
      expose :user_id, :as => :cache_owner
      expose :primary_tag, :using => UrbanFruitProject::Entities::Tag
      expose :tags, :using => UrbanFruitProject::Entities::Tag
      expose :description
      expose :location
      expose :latitude
      expose :longitude
      expose :images, :using => UrbanFruitProject::Entities::Image
    end
  
  end
end