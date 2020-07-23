class ApplicationController < ActionController::Base
  
	protect_from_forgery
    
    #use to set session timeout after inactivitity of 10minutes
  before_action :check_session_expiry, if: proc{!request.url.include?('access/login')}

  def check_session_expiry
    if !session[:expires_at].nil? and session[:expires_at] < Time.now
      redirect_to signin_url
    end    
    session[:expires_at] = 10.minutes.from_now
    #session[:expires_at] = MAX_SESSION_TIME.seconds.from_now 
  end


  protected #A method that can't be call by action but use by other controllers in the apps

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to(:controller => 'access', :action => 'login')
      return false # halts the before_filter
    else
      return true
    end    
  end
end
