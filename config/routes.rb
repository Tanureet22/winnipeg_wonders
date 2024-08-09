Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'pages/show'
  get '/contact', to: 'pages#show', id: 'Contact'
  get '/about', to: 'pages#show', id: 'About'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  get 'addresses/new'
  get 'addresses/create'
  get 'orders/new'
  get 'orders/create'
  get 'orders/show'
  get 'orders/index'
  get 'carts/show'

  resources :products, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :categories, only: [] do
    member do
      get :products, to: 'products#category'
    end
  end

  resource :cart, only: [:show, :update, :destroy]
  resources :orders, only: [:new, :create, :show, :index]
  resources :addresses, only: [:new, :create]
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]

  root 'products#index'
end
