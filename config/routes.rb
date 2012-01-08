Sherlock::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "log_out"
  get "login" => "sessions#new", :as => "log_in"
  get "signup" => "users#new", :as => "sign_up"

  resources :users
  resources :sessions

  match ':username' => 'users#show'

  root :to => "sessions#new"


end

