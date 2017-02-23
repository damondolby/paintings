class PaintingController < ApplicationController

  
  def all
     @paintings = Painting.find(:all)
  end
  
  def one
    @painting = Painting.find(params[:id])
  end
 
 def home   
 end
end
