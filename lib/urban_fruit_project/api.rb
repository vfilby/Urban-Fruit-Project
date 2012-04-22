class UrbanFruitProject::API < Grape::API
  prefix 'api'
  version 'v1', :using => :header, :vendor => "Urban Fruit Prject"
  format :json
  default_format :json
  
  
  resource "cache" do
    
    # Loads a cache
    #
    # @param [id] The id of the cache you want to load
    get "/show/:id" do
      @fruit_cache = FruitCache.find(params[:id])
    end
    
    # Search for caches
    #
    # Either specify a lat/long or a location string
    #
    # @param [latitude] Latitude of the search center
    # @param [longitude] Longitude of the search center
    # @param [location] A location string to be geocoded
    get "/search" do

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
    end
    
    segment '/:cache_id/' do
      
      resource :images do
        # Get a list of images associated with a cache
        #
        # 
        get '/' do
          @fruit_cache = FruitCache.find(params[:cache_id]).images
        end

        # Get a specific image belonging to a cache
        #
        get '/:image_id' do
          @fruit_cache = FruitCache.find(params[:cache_id]).images.find(params[:image_id])          
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
end