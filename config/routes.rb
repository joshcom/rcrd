class LoggedInConstraint
  def initialize(value)
    @value = value
  end

  def matches?(request)
    !request.cookies.key?("user_id") == @value
  end
end


Nassau::Application.routes.draw do
  resources :records
  resources :users
  resources :sessions
  
  get 'cats/:name' => 'cats#show', :as => :cat
  
  get 'public' => 'home#public', as: 'public'
  get 'trends' => 'home#trends', as: 'trends'
  get 'input' => 'home#input', as: 'input'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  root :to => "home#index"#, :constraints => LoggedInConstraint.new(false)
#root :to => "home#dashboard", :constraints => LoggedInConstraint.new(true)
end
