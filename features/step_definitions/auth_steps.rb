#Opening administrators panel /admin
When (/I go to the admin site$/) do
  visit('/admin')
end

#digest auth in admin site
When /log in$/ do
  page.driver.browser.basic_authorize('admin', 'test')
end