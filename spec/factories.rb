# This will guess the User class
FactoryGirl.define do
  
  factory :survey do
    title "Survey title"
    author "Author"
    description "Decsription"
  end
  
  factory :question do
    content 'Custom answer'
    survey
  end
    
  factory :survey_result do
    sequence( :ip_address ) { |n| "10.0.0.#{n}" }
    survey
    user_answer
  end
  
  factory :user_answer do
    content 'Custom answer'
    survey_result
    question
  end
  
end