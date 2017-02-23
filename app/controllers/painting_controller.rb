class PaintingController < ApplicationController
  caches_page :all, :one, :home, :painting
  
  def all
     @paintings = Painting.find(:all)
  end
  
  def one
    @painting = Painting.find(params[:id])
  end
  
  def painting
    @painting = Painting.find(params[:id])
    send_data(@painting.image_data, :filename => @painting.image_name, 
    :type => @painting.content_type,
    :disposition => "inline")
  end
 
 def home   
 end
end
