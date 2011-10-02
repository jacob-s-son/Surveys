require 'base64'
  
module CucumberHelpers
  def authorize(username, password)
    if page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize) #Rack::Test
      page.driver.browser.basic_authorize(username, password)
    else #using Webkit
      page.driver.header('AUTHORIZATION', 'Basic ' + Base64.encode64("#{username}:#{password}"))
    end
  end
end

World(CucumberHelpers)