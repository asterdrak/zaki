# frozen_string_literal: true
Rails.application.routes.draw do
  resources :committees do
    match 'trials', to: 'trials#clear_permitted_trials', via: :delete, as: 'trial_clear_permitted'
    resources :trials do
      match 'state/:state_id', to: 'trials#set_state', via: :patch, as: 'set_state'
      match 'authorize/:private_key_digest', to: 'trials#receive_private_key_digest', via: :get,
                                             as: :authorize
      match '', to: 'trials#receive_private_key', via: :post
    end
    resources :ranks, only: [:create, :destroy]
    resources :environments, only: [:create, :destroy, :edit, :update]
  end

  root 'home#index'
  match 'home/private_index' => 'home#private_index', via: :get
  match 'permitted_keywords' => 'home#permitted_keywords', via: :get

  # omniauth
  get '/auth/:provider/callback' => 'user_sessions#create'
  get '/auth/failure' => 'user_sessions#failure'

  # Custom logout
  match '/logout', to: 'user_sessions#destroy', via: :all
end
