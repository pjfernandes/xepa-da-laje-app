Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"


  resources :products, only: %i[new create index show] do
    resources :orders, only: [ :new, :create ]
  end

  resources :users do
    resources :orders, only: %i[index show]
  end

end
