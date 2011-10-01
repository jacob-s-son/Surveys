FactoryGirl.define do  
  
  #General case - survey has answer with question and prepared answer
  factory :survey do
    title "Survey title"
    author "Author"
    description "Decsription"
  end
  
  factory :question do
    content 'Question with prepared answer'
    survey
  end
  
  factory :question_with_answers, :parent => :question do
    after_create { |q| Factory(:answer, :question => q) }
  end
  
  factory :answer do
    content 'Given answer'
    question
  end
    
  factory :survey_result do
    sequence( :ip_address ) { |n| "10.0.0.#{n}" }
    survey
  end
  
  factory :user_answer do
    content nil
    survey_result
    association :question, :factory => :question_with_answers
    answer
  end
  
  #case with custom answer
  factory :question_without_answers, :class => Question do
    content 'Question with custom answer'
    survey
    answers []
  end
  
  factory :user_answer_custom, :class => UserAnswer do
    content "User's answer"
    answer nil
    survey_result
    association :question, :factory => :question_without_answers
  end
    
end