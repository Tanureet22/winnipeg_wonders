Rails.application.routes.draw do
  # Static pages
  get '/contact', to: 'pages#show', id: 'Contact'
  get '/about', to: 'pages#show', id: 'About'

  # Devise for Admin and Users
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  # ActiveAdmin routes
  ActiveAdmin.routes(self)

  # Resource routes
  resources :categories, only: [:index, :show] do
    member do
      get :products, to: 'products#category'
    end
  end

  resources :products, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resource :cart, only: [:show, :update, :destroy] do
    resources :line_items, only: [:create]
  end

  resources :orders, only: [:new, :create, :show, :index]
  resources :addresses, only: [:new, :create]
  resources :line_items, only: [:create]

  

  # Root route
  root 'products#index'
end
