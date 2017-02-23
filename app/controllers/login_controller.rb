class LoginController < ApplicationController
   
   before_filter :authorise, :except => :login
   
   def login
   if request.get?
     session[:user_id] = nil
     @user = User.new
   else
      @user = User.new(params[:user])
      logged_in_user = @user.try_to_login
      if logged_in_user
        session[:user_id] = logged_in_user.id
        redirect_to(:controller => "admin", :action => "list")
      else
        flash[:notice] = 'Invalid User.'
      end      
  end  
  
end

  def new
    if request.get?
      @user = User.new
    else
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = 'User was successfully created.'
        redirect_to :action => 'list'
      end
    end
  end
  
    def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to :action => 'login'
  end
  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end
  
  def destroy
    begin
      User.find(params[:id]).destroy
      flash[:notice] = "User #{user.name} deleted"
    rescue
      flash[:notice] = "Can't delete this user"
    end
    redirect_to :action => 'list'
  end
end
