Nassau::Application.routes.draw do
  resources :records
  resources :users
  resources :sessions
  
  match 'cats/:name' => 'cats#show', :as => :cat

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  root :to => 'home#index'
end
