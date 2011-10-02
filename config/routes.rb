Surveys::Application.routes.draw do
  
  scope(:admin) do
    resources :answers, :only => [:index]
    resources :questions, :only => [:index]
    resources :surveys
    
    match 'admin' => 'admin/surveys#index'
  end
  
  resources :user_answers
  resources :survey_results  
  root :to => "survey_results#index"
end
