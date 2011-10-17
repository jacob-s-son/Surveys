Surveys::Application.routes.draw do
  
  namespace :admin do
    resources :answers, :only => [:index]
    resources :questions, :only => [:index]
    resources :surveys do
      resources :survey_results, :only => [:index]
      resources :user_answers, :only => :index
    end
    
    root :to => 'surveys#index'
  end
  
  resources :surveys, :only => [:index] do
    resources :survey_results , :only => [:new, :create]
  end
  
  root :to => "surveys#index"
end
