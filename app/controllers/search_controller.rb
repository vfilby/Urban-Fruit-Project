class SearchController < ApplicationController
  respond_to :html, :xml, :json
    
  def index
    @fruit_caches = []
    
    return unless params[:q] && params[:q].length > 0

    vars = parse_query(params[:q])
    @query = params[:q]
    
    if vars.has_key?( :keyword )
      keywords = "#{vars[:keyword]}"
      @keyword = vars[:keyword]
    else
      keywords = "__type:FruitCache"
    end
    
    #Specified lat/long get the first kick.
    if params[:latitude] && params[:longitude]
      latitude = params[:latitude] |
      longitude = params[:longitude]
    end
    
    # Fall back on location if present
    if vars.has_key?( :location ) && !latitude && !longitude
      @location = vars[:location]
      location = Geocoder.search(vars[:location])

      latitude = location[0].latitude if location[0]
      longitude = location[0].longitude if location[0]
    else
      latitude = lat_long[:latitude] || request.location.latitude
      longitude = lat_long[:longitude] || request.location.longitude
    end
    
    if latitude && longitude && keywords
      @fruit_caches = FruitCache.search_tank( 
        keywords,
        :page => (params[:page] || 1),
        :var0 => latitude,
        :var1 => longitude,
        :function => 1,
        :filter_functions => {1 => [[-50,0]]}
      )
    else 
      @fruit_caches = []
    end
    
    @google_maps_json = @fruit_caches.to_gmaps4rails do |cache,marker|
      marker.infowindow render_to_string( :partial => "fruit_caches/map_info", :locals  => { :cache => cache } )
      marker.title cache.name
      marker.sidebar cache.name
      marker.json( { :id => cache.id })
    end
    
    #debugger
    #log_search( params[:q] )
    
    respond_with(@fruit_caches)
  end
  

  def log_search( query )
    debugger
    logger.debug( "User search: #{query}")
  end
  #handle_asynchronously :log_search
  
  private ####################################
  

  
  # Assume formats
  # keyword near location (cherries near Guelph, ON)
  # keyword in location (apples in ottawa)
  # if near doesn't exist then assume it is a keyword and search based on their browser location
  # try to recognize some lat/longs or locations by searching for commas
  def parse_query( query )
    keyword_and_location_re = /[ ]+(?:near|in|around|at)[ ]+/
    location_indicator_re = /,|[0-9]+/
    
    if query =~ keyword_and_location_re
      keyword, location = query.split( keyword_and_location_re, 2 )
      return { :keyword => keyword, :location => location }
    end
    
    if query =~ location_indicator_re
      return { :location => query }
    end
    
    return { :keyword => query }
  end
end
