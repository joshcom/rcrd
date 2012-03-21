Nassau::Application.routes.draw do
  get 'records/export'

  get "sessions/new"

  get "users/new"
  
  get "users/edit"

  resources :records

  get "records/index"
  match 'records/jellyfish' => 'records#jellyfish'
  
  match 'cats/:name' => 'cats#show', :as => :cat


  resources :records do
    resources :cats
  end
  
  resources :karmas
  
  # TEMP TEMP TEMP
  get "changeover" => "records#changeover", :as => "changeover"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  
  resources :users
  resources :sessions
  
  root :to => 'home#index'
end
