class FruitCachesController < ApplicationController
  
  # GET /fruit_caches
  # GET /fruit_caches.xml
  def index
    @fruit_caches = FruitCache.all
    @google_maps_json = @fruit_caches.to_gmaps4rails
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fruit_caches }
    end
  end

  # GET /fruit_caches/1
  # GET /fruit_caches/1.xml
  def show
    @fruit_cache = FruitCache.find(params[:id])
    @json = @fruit_cache.to_gmaps4rails do |cache, marker|
      "\"id\":#{cache.id}" 
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fruit_cache }
    end
  end

  # GET /fruit_caches/new
  # GET /fruit_caches/new.xml
  def new
    @fruit_cache = FruitCache.new
    @fruit_cache.images.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fruit_cache }
    end
  end

  # GET /fruit_caches/1/edit
  def edit  
    debugger
    @fruit_cache = FruitCache.find(params[:id])
    authorize! :edit, @fruit_cache
  end

  # POST /fruit_caches
  # POST /fruit_caches.xml
  def create    
    authorize! :create, FruitCache
    debugger 
    # Process the comma separated tags
    params[:fruit_cache][:tag_ids] = params[:fruit_cache][:tags].split( "," )
    params[:fruit_cache].delete( :tags )
    
    @fruit_cache = FruitCache.new(params[:fruit_cache])
    @fruit_cache.user = current_user
  
    
    respond_to do |format|
      if @fruit_cache.save
        
        message = ":user just created a new cache! #{fruit_cache_url( @fruit_cache )}" 
        Tweeter::TimeLine.tweet( message, { :user => current_user.name } ) rescue nil
        
        format.html { redirect_to(@fruit_cache, :notice => 'Fruit cache was successfully created.') }
        format.xml  { render :xml => @fruit_cache, :status => :created, :location => @fruit_cache }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fruit_cache.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fruit_caches/1
  # PUT /fruit_caches/1.xml
  def update
    @fruit_cache = FruitCache.find(params[:id])
    authorize! :update, @fruit_cache
    debugger
    
    # process the primary tag
    params[:fruit_cache][:primary_tag_id] = Tag.process_tag_id params[:fruit_cache][:primary_tag_id]
    #params[:fruit_cache].delete( :primary_tag )
    
    # Process the comma separated tags
    params[:fruit_cache][:tag_ids] = Tag.process_tag_ids( params[:fruit_cache][:tags] )
    params[:fruit_cache].delete( :tags )

    respond_to do |format|
      if @fruit_cache.update_attributes(params[:fruit_cache])
        format.html { redirect_to(@fruit_cache, :notice => 'Fruit cache was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fruit_cache.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fruit_caches/1
  # DELETE /fruit_caches/1.xml
  def destroy
    @fruit_cache = FruitCache.find(params[:id])
    authorize! :delete, @fruit_cache
    
    @fruit_cache.destroy

    respond_to do |format|
      format.html { redirect_to(fruit_caches_url) }
      format.xml  { head :ok }
    end
  end

end
