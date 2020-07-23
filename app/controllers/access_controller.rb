class AccessController < ApplicationController
  
  layout 'admin'

  before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]
  def index
  	menu
  	render 'menu'
  end

  def menu
  	# just to diplay text and link
  end

  def login
  	# just to display login form
  end

  def attempt_login
  	authorized_user = AdminUser.authenticate(params[:username], 
  		params[:password])
  	if authorized_user 
  		#TODO: mark user as logged in
      reset_session
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      session[:user_name] = authorized_user.name
  		flash[:notice] = "You are now logged in"
  		redirect_to(:action => 'menu')
  	else 
  		flash[:notice] = "Invalid username/password combination"
  		redirect_to(:action => 'login')
  	end

  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
  	flash[:notice] = "You have successfully logged out."
  		redirect_to(:action => 'login')
  end
  
end
