# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end
  
  def clear_title
    content_for(:title) { "" }
    @show_title = false
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
  
  def nearby_caches_path
    lat = lat_long[:latitude] || request.location.latitude
    long = lat_long[:longitude] || request.location.longitude
    results = Geocoder.search( "#{lat},#{long}")
    if( results[0] )
      return "/search/?q=#{results[0].formatted_address}"
    else  
      return "/search/?q=#{lat},#{long}"
    end
  end
end
