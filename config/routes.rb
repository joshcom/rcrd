Nassau::Application.routes.draw do
  get 'records/export'

  get "sessions/new"

  get "users/new"
  
  get "users/edit"

  resources :records

  get "records/index"
  match 'records/jellyfish' => 'records#jellyfish'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  
  match 'cats/:name' => 'cats#show', :as => :cat

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :records do
    resources :cats
  end
  
  resources :karmas
  
  # TEMP TEMP TEMP
  get "changeover" => "records#changeover", :as => "changeover"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
<<<<<<< HEAD
  
  resources :users
  resources :sessions
  
  root :to => 'home#index'
end
