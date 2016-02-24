Rails.application.routes.draw do
  root 'boards#index'

  get '/logout' => 'sessions#destroy', as: :logout
  get 'signup' => 'users#new', as: :signup
  resources :sessions, only: [:new, :create]

  delete 'users/:id' => 'users#destroy', as: :users_destroy
  resources :users

  delete 'boards/:id' => 'boards#destroy', as: :boards_destroy
  resources :boards


end
