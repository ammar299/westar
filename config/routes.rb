Rails.application.routes.draw do
  namespace :admin do
      resources :orders
      resources :order_items
      resources :parts
      resources :users

      root to: "orders#index"
    end
  # Devise routes for user authentication
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Resources for parts
  resources :parts do
    post 'add_to_cart', on: :member
    get 'add_to_cart_js', on: :member
  end

  # Resources for orders
  resources :orders

  # Root route
  root 'parts#index'

  # Additional routes
  get 'pages/about'
  get 'pages/contact'
end