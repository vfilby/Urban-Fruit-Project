class UsersController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json
  
  
  def index
    @users = User.all
    respond_with @users  
  end

  def show
    @user = User.find(params[:id])
    respond_with @user
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def new
    if !session.has_key?(:omniauth) 
      flash[:error] = "NO authorizations associated with new user"
      redirect_to new_user_path
    end
    @user = User.new
    @user.valid?
    #debugger
  end
  
  def create
    @user = User.new(params[:user])
    
    #clear omniauth data if it is in the session
    if session.has_key?(:omniauth) 
      @user.build_authorization(session[:omniauth])
      @user.valid?
    end
    
    if @user.save
      session[:omniauth] = nil
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id]) || current_user
    @user.destroy
    flash[:notice] = "User destroyed"
    redirect_to root_url
  end
  
  def profile
    
  end

end
