Rails.application.routes.draw do
  root to: 'events#index'

  get    '/signin',   to: 'sessions#new'
  post   '/signin',   to: 'sessions#create'
  delete '/signout',  to: 'sessions#delete'

  get '/signup',  to: 'users#new'
  resources :users
end
