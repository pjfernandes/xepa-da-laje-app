Rails.application.routes.draw do
  devise_for :users
  #root to: 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "products/new", to: "products#new" # The `new` route
  post "products", to: "products#create"

  # get "orders/new", to: "orders#new" # The `new` route
  # post "orders", to: "orders#create"

  root to: "products#index"
  get 'products/:id', to: 'products#show', as: :product

  resources :products, except: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :orders, only: [ :show, :new, :create ]
  end
end
