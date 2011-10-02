class AdministratorController < ApplicationController
  require 'digest'
  before_filter :auth
  
  private
  def auth
    Rails.logger.info(request.headers.keys.inspect)
    Rails.logger.info(request.remote_ip)
    authenticated = authenticate_or_request_with_http_basic(DIGEST_AUTH['realm']) do |username, password|
      username == 'admin' && Digest::MD5.hexdigest(password) == DIGEST_AUTH[username]
    end
    
    unless authenticated
      request_http_basic_authentication("Admin", "Authentication failed !")
    end
  end
end