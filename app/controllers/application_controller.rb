class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  delegate :current_user, :user_signed_in?, :to => :user_session

  helper_method :current_user, :user_signed_in?

  def user_session 
  	UserSession.new(session) 
  end

  def require_authentication 
  	unless user_signed_in? 
  		redirect_to new_user_sessions_path, 
  		:alert => t('flash.alert.needs_login') 
  	end 
  end

	def require_no_authentication 
		redirect_to root_path if user_signed_in? 
	end 

end
