Rails.application.routes.draw do

  root 'robots#index'

  get '/requests', to: 'robots#requests', as: :send_requests
  get '/random_song', to: 'robots#random_song', as: :send_random_song


end
