class SearchController < ApplicationController
  respond_to :html, :xml, :json
    
  def index
    @query = ''
    @fruit_caches = []
    
    
    if( !params[:q].nil? ) then
      @query = params[:q]
      logger.debug(params[:q])
      location = Geocoder.search(params[:q])

      
      logger.debug location[0].latitude
      logger.debug location[0].longitude
      
      @fruit_caches = FruitCache.search_tank( 
        '__type:FruitCache',
        :var0 => location[0].latitude,
        :var1 => location[0].longitude,
        :function => 1,
        :filter_functions => {1 => [[-50,0]]}
      )
    end
    
    respond_with(@fruit_caches)
  end
end
