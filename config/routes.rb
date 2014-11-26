Rails.application.routes.draw do
  root 'robots#index'
  resources :movies, only: [:create, :destroy]
end
