Rails.application.routes.draw do

  root 'robots#index'
  resources :find, only: [:create]
end
