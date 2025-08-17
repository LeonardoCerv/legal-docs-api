class ApplicationController < ActionController::Base
  include Authentication
  include JwtAuthentication
  
  # Skip CSRF for API endpoints
  skip_before_action :verify_authenticity_token, if: :api_request?
  
  private
  
  def api_request?
    request.path.start_with?('/auth') || 
    request.path.start_with?('/documents') || 
    request.path.start_with?('/templates') || 
    request.path.start_with?('/organization')
  end
endss ApplicationController < ActionController::API
  include Authentication
end
