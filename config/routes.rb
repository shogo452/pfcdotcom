# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'products#index'
  resources :products do
    resources :reviews
    resources :likes, only: %i[create destroy]
    resources :favorites, only: %i[create destroy]
    collection do
      get 'tag_index'
    end
    get 'tag_search', on: :collection, defaults: { format: 'json' }
    get 'tag_search', on: :member, defaults: { format: 'json' }
  end
  resources :relationships, only: %i[create destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :balances, only: %i[create update]
  resources :records, only: %i[create destroy]
  resources :messages, only: [:create]
  resources :rooms, only: %i[create show]
  resources :notifications do
    collection do
      get 'destroy_all'
    end
  end

  get 'inquiry' => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks' => 'inquiry#thanks'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
