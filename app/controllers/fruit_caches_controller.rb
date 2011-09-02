class FruitCachesController < ApplicationController
  # GET /fruit_caches
  # GET /fruit_caches.xml
  def index
    @fruit_caches = FruitCache.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fruit_caches }
    end
  end

  # GET /fruit_caches/1
  # GET /fruit_caches/1.xml
  def show
    @fruit_cache = FruitCache.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fruit_cache }
    end
  end

  # GET /fruit_caches/new
  # GET /fruit_caches/new.xml
  def new
    @fruit_cache = FruitCache.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fruit_cache }
    end
  end

  # GET /fruit_caches/1/edit
  def edit
    @fruit_cache = FruitCache.find(params[:id])
  end

  # POST /fruit_caches
  # POST /fruit_caches.xml
  def create
    @fruit_cache = FruitCache.new(params[:fruit_cache])

    logger.debug "FruitCache:"
    logger.debug @fruit_cache
    respond_to do |format|
      if @fruit_cache.save
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
    @fruit_cache.destroy

    respond_to do |format|
      format.html { redirect_to(fruit_caches_url) }
      format.xml  { head :ok }
    end
  end
end
