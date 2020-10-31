Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  resources :products do
    resources :reviews
    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    collection do
      get 'tag_index'
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :balances
  resources :records
end
