class HomeController < ApplicationController
  respond_to :html, :xml, :json

  def index
    
    respond_with(@model) do |format|
      format.html {  }
    end
  end
end
