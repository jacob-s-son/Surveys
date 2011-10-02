class AdministratorController < ApplicationController
  require 'digest'
  before_filter :auth
  
  private
  def auth
    authenticated = authenticate_or_request_with_http_basic(DIGEST_AUTH['realm']) do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == 'admin' && md5_of_password == DIGEST_AUTH[username]
    end
    
    unless authenticated
      request_http_basic_authentication("Admin", "Authentication failed !")
    end
  end
end