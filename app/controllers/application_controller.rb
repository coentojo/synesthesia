class ApplicationController < ActionController::Base
  #include Facebooker2::Rails::Controller
  protect_from_forgery
  helper_method :current_user
  
  private 
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    
  end
  
end
