class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :lat_long
  helper_method :stored_lat_long?
  
  protected
  
  def render_not_found(exception)
    log_error(exception)
    render :template => "/error/404.html.haml", :status => 404
  end

  def render_error(exception)
    log_error(exception)
    render :template => "/error/500.html.haml", :status => 500
  end
  

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
  
  def stored_lat_long?
    return !cookies[:lat_lng].nil?
  end
  
  def lat_long
    return { } unless cookies[:lat_lng]
    
    latitude, longitude = cookies[:lat_lng].split("|")
    { latitude: latitude, longitude: longitude }
  end
end
