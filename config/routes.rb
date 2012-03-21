Nassau::Application.routes.draw do

  get "sessions/new"

  get "users/new"  
  get "users/edit"

  get 'records' => 'home#index'
  get 'records/all' => 'records#all'

  resources :records

  match 'records/jellyfish' => 'records#jellyfish'
  
  match 'cats/:name' => 'cats#show', :as => :cat

  # also temp temp
  match 'specialimport' => 'records#specialImport'

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
