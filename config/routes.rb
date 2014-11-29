require 'sidekiq/web'

Rails.application.routes.draw do
  root 'robots#index'
  resources :movies, only: [:create, :destroy]
  mount Sidekiq::Web => '/sidekiq'
end
