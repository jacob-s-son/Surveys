#delete all records of specified tables (classes)
Given(/^no (.+)$/) do |models|
  models.split(', ').each do |model|
    Kernel.const_get(model.singularize.capitalize).delete_all
  end
end

#searching text
Then /^I should see "([^"]*)" within "([^"]*)"$/ do |text, selector|
  find(:xpath, "//#{selector}[contains(text(),'#{text}')]").should_not(be_nil, "Could not find the text '#{text}' within the selector '#{selector}'")
end