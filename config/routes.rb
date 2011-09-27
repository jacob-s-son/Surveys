Surveys::Application.routes.draw do
  resources :answers

  resources :questions

  resources :surveys
  
  root :to => "surveys#index"
end
