Surveys::Application.routes.draw do
  
  namespace :admin do
    resources :answers, :only => [:index]
    resources :questions, :only => [:index]
    resources :surveys
    root :to => 'surveys#index'
  end
  
  resources :user_answers
  resources :surveys, :only => [:index] do
    resources :survey_results , :only => [:new, :create]
  end
  
  root :to => "surveys#index"
end
