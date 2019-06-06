Rails.application.routes.draw do
  root "sessions#new"
  resources :users, only: [:new, :create]
  resources :companies
  resources :sessions, only: [:new, :create, :destroy]
  get '/dashboard', to: 'dashboards#show', as: 'dashboard'
  get '/transactions', to: 'dashboards#transactions', as: 'transactions'
  post '/transactions', to: 'transactions#create', as: 'create_transaction'
  
end
