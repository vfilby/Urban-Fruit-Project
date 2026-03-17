class LogEntriesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_fruit_cache
  
  # GET /log_entries
  # GET /log_entries.xml
  def index
    redirect_to( @fruit_cache )
  end

  # GET /log_entries/1
  # GET /log_entries/1.xml
  def show
    @log_entry = @fruit_cache.log_entries.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @log_entry }
    end
  end

  # GET /log_entries/new
  # GET /log_entries/new.xml
  def new
    @log_entry = @fruit_cache.log_entries.build
    @log_entry.user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @log_entry }
    end
  end

  # GET /log_entries/1/edit
  def edit
    @log_entry = @fruit_cache.log_entries.find(params[:id])
  end

  # POST /log_entries
  # POST /log_entries.xml
  def create
    @log_entry = @fruit_cache.log_entries.build(params[:log_entry])
    @log_entry.user = current_user
    respond_to do |format|
      if @log_entry.save
        format.html { redirect_to([@fruit_cache], :notice => 'Log entry was successfully created.') }
        format.xml  { render :xml => @log_entry, :status => :created, :location => @log_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @log_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /log_entries/1
  # PUT /log_entries/1.xml
  def update
    @log_entry = @fruit_cache.log_entries.find(params[:id])

    respond_to do |format|
      if @log_entry.update_attributes(params[:log_entry])
        format.html { redirect_to(@fruit_cache, :notice => 'Log entry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @log_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /log_entries/1
  # DELETE /log_entries/1.xml
  def destroy
    @log_entry = @fruit_cache.log_entries.find(params[:id])
    @log_entry.destroy

    respond_to do |format|
      format.html { redirect_to(@fruit_cache, :notice => 'Log entry was deleted.') }
      format.xml  { head :ok }
    end
  end
  

  def find_fruit_cache
    @fruit_cache = FruitCache.find(params[:fruit_cache_id])
  end

end
