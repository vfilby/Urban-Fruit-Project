class BrowseController < ApplicationController

  def tag
    debugger
    if params[:hierarchy]
      parts = params[:hierarchy].split( '/' )
      parent = Tag.find_by_id( parts.last.to_i )
      @tags = parent.children
      @caches = FruitCache.find_all_by_primary_tag_id( parent.id )
      @google_maps_json = @caches.to_gmaps4rails do |cache,marker|
        marker.infowindow render_to_string( :partial => "fruit_caches/map_info", :locals  => { :cache => cache } )
        marker.title cache.name
        marker.sidebar cache.name
        marker.json( { :id => cache.id })
      end
    else
      @tags = Tag.find_all_by_parent_id( nil )
      @caches = []
    end
    
  end
  
  def location
    # "/" select all precalculated locations that don't have a parent
    # "/ontario/" all that have ontario for the root 
    debugger
    if params[:hierarchy]
      puts params[:hierarchy]
      parts = params[:hierarchy].split( '/' )
      @location = CachedBrowseLocation.find_by_id( parts.last.to_i )
      @child_locations = @location.children
      
      if( @location.fruit_caches.count > 0 )
        @tags = @location.fruit_caches.map( &:primary_tag ).uniq.sort
      end
    else
      @child_locations = CachedBrowseLocation.root.children
    end
    
  end
  
end
