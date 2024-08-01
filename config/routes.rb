# Rails.application.routes.draw do
#   resources :products
#   root 'pages#home'
#   get 'pages/about'
# end


Rails.application.routes.draw do
  resources :parts
  resources :products, only: [:index, :show]
  get 'products/:make/:model/:year/:slug', to: 'products#show', as: 'product_detail'
  root 'application#home'
end