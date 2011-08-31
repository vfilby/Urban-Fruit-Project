class SearchController < ApplicationController
  def index
    
    city = request.location.city
    country = request.location.country_code
    
    logger.debug( "City: " + city )
    logger.debug( "Country: " + country )
    logger.debug( Geocoder.search( '24.150.170.42'))
    
    @map = Cartographer::Gmap.new( 'map' )
      @map.zoom = :bound
      @map.icons << Cartographer::Gicon.new
      marker1 = Cartographer::Gmarker.new(:name=> "taj_mahal", :marker_type => "Building",
                  :position => [27.173006,78.042086],
                  :info_window_url => "/url_for_info_content")
      marker2 = Cartographer::Gmarker.new(:name=> "raj_bhawan", :marker_type => "Building",
                  :position => [28.614309,77.201353],
                  :info_window_url => "/url_for_info_content")

      @map.markers << marker1
      @map.markers << marker2
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end
end
