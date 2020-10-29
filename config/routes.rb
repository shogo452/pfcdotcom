Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  resources :products do
    resources :reviews
    collection do
      get 'tag_index'
    end
  end
  resources :users
  resources :balances
  resources :records
end
