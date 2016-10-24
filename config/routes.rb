Rails.application.routes.draw do
  resources :friendships
  resources :conversations do
  resources :messages
 end
 delete '/logout' => 'sessions#destroy'
  
  resources :sessions , only: [:new, :create]
  resources :users
  root  'home#index'
  
end
