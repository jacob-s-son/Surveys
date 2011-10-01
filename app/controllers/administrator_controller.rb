class AdministratorController < ApplicationController
  before_filter :auth
  
  private
  def auth
    authenticated = authenticate_or_request_with_http_digest(DIGEST_AUTH['realm']) do |username|
      DIGEST_AUTH[username]
    end
    
    unless authenticated
      request_http_digest_authentication("Admin", "Authentication failed !")
    end
  end
end