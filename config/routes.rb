Rails.application.routes.draw do
  resources :orders, only: [:index, :new, :create, :show, :update]
  resources :cart_items, only: [:create, :destroy, :show, :edit]
  resources :carts, only: [:show] do
    post :add_product
  end
  resources :products do
    collection { get :search }
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  get  "login",  to: "sessions#new",     as: :login
  post "login",  to: "sessions#create"
  get  "logout", to: "sessions#destroy", as: :logout
  get  "signup", to: "users#new",        as: :signup
  post "signup", to: "users#create"

  root "products#index"
end

