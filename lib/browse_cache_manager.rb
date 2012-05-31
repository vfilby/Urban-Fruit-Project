module BrowseCacheManager
  require 'Geonames'
  
  def add_location( latitude, longitude )
    options = {
      maxRows: 50,
      radius: 50,
      style: "full",
    }

    nearby_places = Geonames::WebService.find_nearby_place_name( latitude, longitude, options ).reject { |o| o.population <= 0 }
    nearby_places.each do |place|
      location = CachedBrowseLocation.new({:name => place.name, :id => place.geoname_id.to_i })
      save_hierarchy( location )
    end
  rescue Exception => e
    error( e.message )
  end
  handle_asynchronously :add_location

  
  def remove_location( latitude, longitude )
    options = {
      maxRows: 50,
      radius: 50,
      style: "full",
    }

    nearby_places = Geonames::WebService.find_nearby_place_name( latitude, longitude, options ).reject { |o| o.population <= 0 }
    nearby_places.each do |place|
      cache_count = FruitCache.near( [place.latitude,place.longitude], 31 ).count
      if( cache_count <= 0 )
        cached_location = CachedBrowseLocation.find_by_id( place.geoname_id.to_i )
        if cached_location
          delete_hierarchy( cached_location )
        end
      end
    end    
  rescue Exception => e
    error( e.message )
  end
  handle_asynchronously :remove_location
  
  
  def delete_hierarchy( browse_location )
    current = browse_location
    while( true ) do
      if current.nil? || current.children.count > 0
        return
      end
      
      parent = current.parent
      current.destroy
      current = parent
    end
  end

  
  
  def save_hierarchy( browse_location )
 
    if browse_location.parent_id && CachedBrowseLocation.find( browse_location.parent_id )
      return
    end
    
    hierarchy = Geonames::WebService.hierarchy( browse_location.id )
    hierarchy.each_index do |i|
      current = hierarchy[i]
      
      next if CachedBrowseLocation.find_by_id( current.geoname_id.to_i )
      
      parent_id = (i > 0) ? hierarchy[i-1].geoname_id.to_i : nil
      name = current.name
      id = current.geoname_id.to_i
      
      c = CachedBrowseLocation.new( {:name => name, :id => id, :parent_id => parent_id} )
      c.save!
    end
    
  end
end