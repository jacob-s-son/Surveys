#Opening administrators panel /admin
When (/I go to the admin site$/) do
  visit('/admin')
end

#digest auth in admin site
When /log in with (.+):(.+)$/ do |username, password|
  page.driver.browser.basic_authorize(username, password)
end