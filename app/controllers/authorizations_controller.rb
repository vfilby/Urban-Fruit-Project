class AuthorizationsController < ApplicationController
  def index
    @authorizations = current_user.authorizations if current_user  
  end

  def show
  end

  def new
  end

  def create
    debugger
    auth = request.env['omniauth.auth']
    authorization = Authorization.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if authorization
      flash[:notice] = "Signed in successfully"
      session[:user_id] = authorization.user
      redirect_to root_url

    elsif current_user
      current_user.authorizations.create(:provider => auth['provider'], :uid => auth['uid'])
      flash[:notice] = "Authorization added to your account"
      redirect_to authorizations_url
    else
      user = User.new
      user.authorizations.build(:provider => auth['provider'], :uid => auth['uid'])
      user.save!
      flash[:notice] = "Signed in, new user created"
      session[:user_id] = user
      redirect_to root_url
    end
  end

  def destroy
    @authorization = current_user.authorizations.find(params[:id])
    @authorization.destroy
    flash[:notice] = "Successfully destroyed authorization"
    redirect_to authorizations_url
  end

end
