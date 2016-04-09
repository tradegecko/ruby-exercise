Rails.application.routes.draw do
  root 'robots#index'

  resources :tweets
end
