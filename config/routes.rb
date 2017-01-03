Rails.application.routes.draw do
  root to: 'events#index'

  get    '/signin',  to: 'sessions#new'
  post   '/signin',  to: 'sessions#create'
  delete '/signout', to: 'sessions#delete'

  get '/signup',    to: 'users#new'
  post '/users',    to: 'users#create', as: 'create_user'
  get '/users/:id', to: 'users#show',   as: 'show_user'
  put '/users/:id', to: 'users#update', as: 'update_user'
  resources :users

  get 'events',        to: 'events#index',  as: 'events'
  get 'events/new',    to: 'events#new',    as: 'new_event'
  get 'events/:id',    to: 'events#show',   as: 'show_event'
  put 'events/:id',    to: 'events#update', as: 'update_event'
  post 'events',       to: 'events#create', as: 'create_event'
  delete 'events/:id', to: 'events#delete', as: 'delete_event'

  get 'apps', to: 'app_authorization_requests#index', as: 'app_authorization_requests'
  post 'apps', to: 'app_authorization_responses#create', as: 'create_app_authorization_response'

  namespace :api do
    namespace :v1 do
      get 'status', to: 'status#index'

      get '/users/:user_id/events', to: 'events#index'

      post 'authorize_app', to: 'app_authorization_requests#create'
    end
  end
end
