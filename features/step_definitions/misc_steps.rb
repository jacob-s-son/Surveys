#Opening administrators panel /admin
When (/I go to the admin site$/) do
  visit admin_root_path
end

#digest auth in admin site
When /log in$/ do
  # page.driver.browser.basic_authorize('admin', 'test')
  authorize('admin', 'test')
end

#combination of the above
Given /^I am on the admin site$/ do
  #debugger
  #page.driver.browser.basic_authorize('admin', 'test')
  authorize('admin', 'test')
  visit admin_root_path
end

#delete all records of specified tables (classes)
Given(/^no (.+)$/) do |models|
  models.split(', ').each do |model|
    Kernel.const_get(model.singularize.capitalize).delete_all
  end
end

#searching text using xpath
Then /^I should see "([^"]*)" within "([^"]*)"$/ do |text, selector|
  find(:xpath, "//#{selector}[contains(text(),'#{text}')]").should_not(be_nil, "Could not find the text '#{text}' within the selector '#{selector}'")
end

#searching text using css selector
Then /^I should see "([^"]*)" in "([^"]*)"$/ do |text, selector|
  element = page.first(:css, "#{selector}")
  element.should_not(be_nil, "Could not find the element '#{selector}'")
  element.has_content?(text).should(be_true, "Could not find the text '#{text}' within the selector '#{selector}'")
end

#click on link
When /^I follow "([^"]*)"$/ do |link_text|
  click_link(link_text)
end

#fill in textfield
When /^I fill in "([^"]*)" with "([^"]*)"$/ do |label, content|
  fill_in(label, :with => content)
end

#make sure checkbox is unckecked
When /^I leave checkbox "([^"]*)" unchecked$/ do |cb_name|
  uncheck(cb_name)
end

#pressing buttons
When /^I press "([^"]*)"$/ do |label|
  click_button(label)
end

#notices/errors
Then /^I should see (notice|error) "([^"]*)"$/ do |msg_type, msg|
  element = page.first(:css, "div#flash_#{msg_type}")
  element.should_not(be_nil, "Could not find flash #{msg_type} container")
  element.has_content?(msg).should(be_true, "Could not find the text '#{msg}' within flash #{msg_type}")
end

#several errors
Then /^I should see errors ((?:"[^"]+",? ?)+)$/ do |msg_arr|
  msg_arr.split(',').map {|m| m.gsub(/"/, '').strip}.each do |msg|
    find(:xpath, "//ul/li[contains(text(),\"#{msg}\")]").should_not(be_nil, "Could not find title '#{msg}'")
  end
end

#current page
Then /^I should be on the ?(\w+)? (admin)?\/(\w+) page$/ do |action, namespace, model|
  current_path.should == self.send( ( "#{action}_" if action ).to_s + 
                                    ( "#{namespace}_" if namespace ).to_s + 
                                    "#{model}_path" )
end

Then /^I should be on the page titled "([^"]+)"/ do |title|
  find(:xpath, "/html/head/title[contains(text(),'#{title}')]").should_not(be_nil, "Could not find title '#{title}'")
end