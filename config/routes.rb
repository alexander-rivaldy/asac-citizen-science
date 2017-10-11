Rails.application.routes.draw do
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  
  get "/404", :to => "errors#not_found"
  get "/500", :to => "errors#internal_server_error"

  
  if Rails.env.production?
     get '404', :to => 'errors#not_found'
     get '500', :to => 'errors#internal_server_error'
  end
  
  get 'sessions/new'

  get 'samples/new'
  get '/map', to: 'samples#map'
  get '/list', to: 'samples#list'
  get '/grid', to: 'samples#grid'
  match 'samples.:id' => 'samples#show', via: :get
  match 'edit/samples.:id' => 'samples#edit', via: :get
  post 'edit/samples.:id', to: 'samples#update'
  get 'users/new'
  get  '/profile',  to: 'users#show'
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
