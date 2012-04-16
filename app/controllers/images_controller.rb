class ImagesController < ApplicationController
  # GET /uploads
  # GET /uploads.xml
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.xml
  def show
    #debugger
    @image = Image.find(params[:id])
    
    authorize! :show, @image
  end

  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /uploads/1/edit
  def edit
    @image = Image.find(params[:id])
    
    authorize! :edit, @image
  end

  # POST /uploads
  # POST /uploads.xml
  def create
    newparams = coerce(params)
    @image = Image.new(newparams[:image])
    if @image.save
      flash[:notice] = "Successfully created Image."
      #debugger
      respond_to do |format|
        format.html {redirect_to @image.fruit_cache}
        format.json {render :json => { :result => 'success', :image => image_path(@image) } }
      end
    else
      render :action => 'new'
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.xml
  def update
    @image = Image.find(params[:id])
    
    respond_to do |format|
      if @Image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Upload was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @Image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.xml
  def destroy
    @image = Image.find(params[:id])
    authorize! :delete, @image

    @image.destroy
      
    respond_to do |format|
      format.html { redirect_to(params[:redirect_to] || images_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  def coerce(params)
    if params[:image].nil? 
      h = Hash.new 
      h[:image] = Hash.new 
      h[:image][:fruit_cache_id] = params[:fruit_cache_id] 
      h[:image][:photo] = params[:Filedata] 
      h[:image][:photo].content_type = MIME::Types.type_for(h[:image][:photo].original_filename).to_s
      h
    else 
      params
    end 
  end
  
end
