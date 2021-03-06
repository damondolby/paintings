# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_NoelPaintings_session_id'
  
  def authorise
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login", :action => "login")
    end
  end
  
  def painting
    @painting = Painting.find(params[:id])
    send_data(@painting.image_data, :filename => @painting.image_name, 
    :type => @painting.content_type,
    :disposition => "inline")
  end
end
