
# Questions and answers

#Adding questions
When /I add ([0-9]+)(?:st|nd|rd|th) question "(.+)" with answer type "(.+)"/ do |sequence, question, type|
  When "I click link \"Add question\""
  When "I fill in \"Question ##{sequence}\" with \"#{question}\""
  When "I select \"#{type}\" from \"Answer is\""
end

#Adding answer
When /I add ([0-9]+)(?:st|nd|rd|th) answer "(.+)" to ([0-9]+)(?:st|nd|rd|th) question/ do |sequence, answer, q_sequence|
  When "I click link \"Add answer\""
  save_and_open_page
  When "I fill in \"Answer ##{q_sequence}.#{sequence}\" with \"#{answer}\""
end