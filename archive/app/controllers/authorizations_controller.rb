class AuthorizationsController < ApplicationController
  protect_from_forgery :except => :create
  
  def index
    @authorizations = current_user.authorizations if current_user
    prev_page = request.env["HTTP_REFERER"] || root_url
    
  end

  def create
    auth = request.env['omniauth.auth']
    authorization = Authorization.find_by_provider_and_uid(auth['provider'], auth['uid'])
    
    if authorization
      flash[:notice] = "Signed in successfully"
      session[:user_id] = authorization.user
      redirect_to profile_path
      
    elsif current_user
      current_user.authorizations.create!(:provider => auth['provider'], :uid => auth['uid'])
      flash[:notice] = "Authorization added to your account"
      redirect_to authorizations_url
    else
      user = User.new
      user.build_authorization( auth )
      if user.save
        flash[:notice] = "Signed in successfully."
        session[:user_id] = user
        redirect_to root_url
      else
        flash[:notice] = "We need a bit more information"
        session[:omniauth] = auth.except('extra')
        redirect_to new_user_path
      end
    end
  end

  def destroy
    if current_user.authorizations.length == 1 
      flash[:error] = "You must have at least one authorization."
    elsif
      @authorization = current_user.authorizations.find(params[:id])
      @authorization.destroy
      flash[:notice] = "Successfully destroyed authorization"
    end
    redirect_to authorizations_url
  end

end
