Rails.application.routes.draw do

  resources :conversations do
  resources :messages
 end
 
  resources :friendships
  delete '/logout' => 'sessions#destroy'
  get '/unread' => 'conversations#unread'
  get '/all' => 'conversations#all'
  resources :sessions , only: [:new, :create]
  resources :users
  root  'home#index'
  

end
