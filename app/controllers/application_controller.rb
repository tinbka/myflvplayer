# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  rescue_from ActionController::RoutingError, :with => :route_not_found
  rescue_from ActionController::MethodNotAllowed, :with => :invalid_method
  filter_parameter_logging :password
  
  def route_not_found
      render :text => '<h1 align="center">Not Found</h1>', :status => :not_found
  end
  
  def invalid_method
    message = '<h1 align="center">Method not allowed</h1>'
    render :text => message, :status => :method_not_allowed
  end
  
end
