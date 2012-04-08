class UrbanFruitProject::API < Grape::API
  prefix 'api'
  version 'v1', :using => :header, :vendor => "Urban Fruit Prject"
  format :json
  default_format :json
  
  
  resource "caches" do
    get "/show/:id" do
      @fruit_cache = FruitCache.find(params[:id])
    end
    
    
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
  end

end