Rails.application.routes.draw do
  get 'carts/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'carts#index'
	post 'add_to_cart', to: 'carts#add'
  post 'remove_from_cart', to: 'carts#remove'
  post 'empty_cart', to: 'carts#empty'
end
