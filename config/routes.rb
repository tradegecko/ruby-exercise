Rails.application.routes.draw do
  resources :tweets, only: [:new, :create]

  root to: 'tweets#new'
end
