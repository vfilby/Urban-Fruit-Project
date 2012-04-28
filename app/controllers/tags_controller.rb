class TagsController < ApplicationController
  respond_to :html
  
  def index
    @tags = Tag.all 
    respond_with @tags
  end

  def show
    @tag = Tag.find(params[:id])
    respond_with @tag
  end

  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
    
    params[:tag][:parent_id] = params[:tag][:parent]
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
