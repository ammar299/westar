Rails.application.routes.draw do
  get 'payments/new'
  get 'payments/create'
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

  get 'payments/new', to: 'payments#new'
  post 'payments', to: 'payments#create'
  get 'success', to: 'payments#success' # Create success action
  get 'error', to: 'payments#error'     # Create error action

end