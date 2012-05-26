class UrbanFruitProject::API < Grape::API
  prefix 'api'
  version 'v1', :using => :header, :vendor => "Urban Fruit Prject"
  format :json
  default_format :json
  
  
  resource "search" do
    # Search for caches
    #
    # Either specify a lat/long or a location string
    #
    # @param [latitude] Latitude of the search center
    # @param [longitude] Longitude of the search center
    # @param [location] A location string to be geocoded
    get "/" do

      latitude = 0.0
      longitude = 0.0
      
      if params.latitude? && params.longitude?
        latitude = params[:latitude]
        longitude = params[:longitude]
      elsif params.location?
        location = Geocoder.search(params[:location])
        latitude = location[0].latitude
        longitude = location[0].longitude
      else
        error!('500 Query Error', 500 )
      end
      
      @fruit_caches = FruitCache.search_tank( 
        '__type:FruitCache',
        :var0 => latitude,
        :var1 => longitude,
        :function => 1,
        :filter_functions => {1 => [[-50,0]]} 
      )
      present @fruit_caches, :with => UrbanFruitProject::Entities::Cache
    end
  end
  
  # http://urbanfruitproject.dev/api/bounding_box?sw_lat=43.494184&sw_long=79.677633&ne_lat=43.494204&ne_long=-79.677653
  get "bounding_box" do
    #debugger
    sw_lat = params[:sw_lat]
    sw_long = params[:sw_long]
    ne_lat = params[:ne_lat]
    ne_long = params[:ne_long]
    @caches = FruitCache.within_bounding_box( [[sw_lat, sw_long],[ne_lat, ne_long]] )
    present @caches, :with => UrbanFruitProject::Entities::Cache
  end
  
  resource "cache" do
    
    # Loads a cache
    #
    # @param [id] The id of the cache you want to load
    get "/:id" do
      @fruit_cache = FruitCache.find(params[:id])
      present @fruit_cache, :with => UrbanFruitProject::Entities::Cache
    end
    
    
    # Creates a new cache
    #
    # @param [json] A JSON object representing the cache. 
    #
    # Format:
    # {
    #   "cache_id":19,
    #   "cache_owner":1,
    #   "name":"Pear Tree",
    #   "description":"Pear Tree",
    #   "location":"Burlington, ON, CA", <== Ignored use lat/long instead
    #   "latitude":43.3649522937441,
    #   "longitude":-79.7653398037541,
    # }
    post "/save" do
      error!( "required json parameter not found", 500 ) unless params[:json] 
      
      parser = Yajl::Parser.new
      h = parser.parse params[:json]
      
      # If updating then load the existing object
      if h["cache_id"] && h["cache_id"] > 0
        cache = FruitCache.find( h["cache_id"])
      else
        cache = FruitCache.new
      end

      begin
        cache.user_id = h["cache_owner"]
        cache.name = h["name"]
        cache.description = h["description"]
        cache.latitude = h["latitude"]
        cache.longitude = h["longitude"]
      
        if cache.save
          "success"
        else
          error!( "Error saving cache: #{cache.errors.to_json}", 500)
        end
      
      rescue Exception => e
        error!( "Error parsing the json object: #{e.to_json}", 500)
      end
    end
    

    
    segment '/:cache_id' do
      
      resource '/images' do
        # Get a list of images associated with a cache
        #
        # 
        get '/' do
          @images = FruitCache.find(params[:cache_id]).images
          present @images, :with => UrbanFruitProject::Entities::Image
        end

        # Get a specific image belonging to a cache
        #
        get '/:image_id' do
          @image = FruitCache.find(params[:cache_id]).images.find(params[:image_id])          
          present @image, :with => UrbanFruitProject::Entities::Image
        end
        
        # Adds a new image to an existing fruit cache
        #
        # @param[cache_id]
        # @param [filename]
        # @param [image]
        # @params [caption]
        post '/upload' do
          @fruit_cache = FruitCache.find(params[:cache_id])
          
          image_params = {
            :fruit_cache_id => @params[:cache_id],
            :photo => ActionDispatch::Http::UploadedFile.new( params[:image] ),
            :caption => params[:caption], 
          }
          
          image = Image.new( image_params )
          
          if image.save!
            "success"
          else
            error!( "Unable to save image", 500)
          end
        end
      end
    end
  end

  resource "test" do
    get "echo" do
      params
    end
    
    post "echo" do
      params
    end
  end

  resource "tags" do
    get "/autocomplete" do
      
      tags = Tag.search_tank( "#{params[:q]}*")
      results = []
      tags.each do |tag|
        results << { :id => tag.id, :name => tag.tag}
      end
      
      results
    end
  end
end
