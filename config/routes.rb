Rails.application.routes.draw do
  root to: 'events#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#delete'

  get '/signup',  to: 'users#new'
  resources :users
end
