# frozen_string_literal: true
Rails.application.routes.draw do
  resources :committees
  resources :trials

  root 'home#index'
  match 'home/private_index' => 'home#private_index', via: :get

  # omniauth
  get '/auth/:provider/callback' => 'user_sessions#create'
  get '/auth/failure' => 'user_sessions#failure'

  # Custom logout
  match '/logout', to: 'user_sessions#destroy', via: :all
end
