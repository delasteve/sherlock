Sherlock::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "log_out"
  get "login" => "sessions#new", :as => "log_in"
  get "signup" => "users#new", :as => "sign_up"

  root :to => "sessions#new"

  resources :users
  resources :sessions
end

