Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
            registrations: "users/registrations",
            sessions: "users/sessions",
          }
  root to: "products#index"
  resources :products do
    resources :reviews
    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    collection do
      get "tag_index"
    end
    get "get_tag_search", on: :collection, defaults: { format: 'json' }
    get "get_tag_search", on: :member, defaults: { format: 'json' }
  end
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :balances
  resources :records
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :notifications do
    collection do
      get "destroy_all"
    end
  end

  get "inquiry" => "inquiry#index"
  post "inquiry/confirm" => "inquiry#confirm"
  post "inquiry/thanks" => "inquiry#thanks"

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
end
