Rails.application.routes.draw do
  get 'sessions/new'

  get 'samples/new'
  get '/map', to: 'samples#map'
  match 'samples.:id' => 'samples#show', via: :get

  get 'users/new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get 'static_pages/home'

  get 'static_pages/help'

  root 'static_pages#home'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  
  
  resources :users
  resources :samples
end
