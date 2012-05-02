module UrbanFruitProject
  module Entities
    class Cache < Grape::Entity
      expose :id, :as => :cache_id
      expose :user_id, :as => :cache_owner
      expose :name
      expose :description
      expose :location
      expose :latitude
      expose :longitude
      expose( :images, :using => UrbanFruitProject::Entities::Image )
      #expose(:images) do |model,options| 
      #   model.images.reduce( [] ) do |a,i| 
      #    a << { :id => i.id, :url => i.photo.url, :caption => i.caption, :filename => i.photo_file_name, :filesize => i.photo_file_size } 
      #  end
      #end
    end
    
    class Image < Grape::Entity
      expose :id
      expose :caption
      expose :photo_file_name, :as => :filename
      expose :photo_file_size, :as => :filesize
      expose(:url) { |model,options| model.photo.url  }
    end
  end
end