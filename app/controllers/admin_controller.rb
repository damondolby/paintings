class AdminController < ApplicationController
  before_filter :authorise
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @painting_pages, @paintings = paginate :paintings, :per_page => 10
  end

  def show
    @painting = Painting.find(params[:id])
  end

  def new
    @painting = Painting.new
  end

  def create
    @painting = Painting.new(params[:painting])
    if @painting.save
      expire_page :controller => "painting", :action => "all"
      flash[:notice] = 'Painting was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

#  def edit
#    @painting = Painting.find(params[:id])
#  end

#  def update
#    @painting = Painting.find(params[:id])
#    if @painting.update_attributes(params[:painting])
#      flash[:notice] = 'Painting was successfully updated.'
#      redirect_to :action => 'show', :id => @painting
#    else
#      render :action => 'edit'
#    end
#  end

  def destroy
    Painting.find(params[:id]).destroy
    expire_page :controller => "painting", :action => "all"
    expire_page :controller => "painting", :action => "one", :id => params[:id]
    #expire_page :controller => "admin", :action => "render_painting_from_db", :id => params[:id]
    expire_page :controller => "painting", :action => "painting", :id => params[:id]
    redirect_to :action => 'list'
  end
end
