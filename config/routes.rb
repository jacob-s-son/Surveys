Surveys::Application.routes.draw do
  resources :user_answers

  resources :survey_results

  resources :answers

  resources :questions

  resources :surveys
  
  root :to => "surveys#index"
end
