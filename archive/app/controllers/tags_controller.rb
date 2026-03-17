class TagsController < ApplicationController
  load_and_authorize_resource :except => [:create]
  respond_to :html
  
  def index
    @tags = Tag.all 
    respond_with @tags
  end

  def show
    respond_with @tag
  end
  
  def new
    debugger
    @tag = Tag.new
    
    respond_with @tag
  end
  
  def create  
    authorize! :create, Tag

    params[:tag][:parent_id] = Tag.process_tag_id( params[:tag][:parent] )
    params[:tag].delete( :parent )
    
    @tag = Tag.new(params[:tag])  
    
    respond_to do |format|
      if @tag.save
        format.html { redirect_to(@tag, :notice => 'Fruit cache was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    #@tag.meta_edit = @tag.read_attribute(:meta).inspect
  end
  
  def update
    params[:tag][:parent_id] = Tag.process_tag_id( params[:tag][:parent] )
    params[:tag].delete( :parent )

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to(@tag, :notice => 'Tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
    
  end

end
