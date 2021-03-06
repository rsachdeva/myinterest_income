# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #before_filter :require_user
  before_filter :set_current_user



  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  helper_method :current_user

  #private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

   def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access previous page"
      redirect_to login_url
      return false
    end
  end


# def require_no_user
#    if current_user
#      store_location
#      flash[:notice] = "You must be logged out to access previous page"
#      redirect_to account_url
#      return false
#    end
#  end


  def store_location
    session[:return_to] = request.request_uri
  end

  def set_current_user
    Authorization.current_user = current_user
  end

  def permission_denied
    flash[:error] = "Sorry, you not allowed to access that page."
    redirect_to customers_path
  end
end
