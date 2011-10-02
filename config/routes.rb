Surveys::Application.routes.draw do
  
  namespace :admin do
    resources :answers, :only => [:index]
    resources :questions, :only => [:index]
    resources :surveys
    root :to => 'surveys#index'
  end
  
  resources :user_answers
  resources :survey_results  
  root :to => "survey_results#index"
end
