#override to use basic auth in tests
# Before do 
#   class AdministratorController 
#     def auth 
#       authenticate_or_request_with_http_basic(DIGEST_AUTH['realm']) do |username, password| 
#         password == DIGEST_AUTH[username]
#       end 
#     end 
#   end 
# end