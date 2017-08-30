Rails.application.routes.draw do
  get 'samples/new'

  get 'users/new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get 'static_pages/home'

  get 'static_pages/help'

  root 'static_pages#home'
  
  resources :users
end
