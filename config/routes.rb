Rails.application.routes.draw do
  root 'sessions#new'

  get '/logout' => 'sessions#destroy', as: :logout
  get 'signup' => 'users#new', as: :signup
  resources :sessions, only: [:new, :create]

  delete 'users/:id' => 'users#destroy', as: :users_destroy
  get 'users/index' => 'users#index', as: :search_users
  resources :users

  delete 'boards/:id' => 'boards#destroy', as: :boards_destroy
  resources :boards
  get 'boards/:id/private' => 'boards#makePrivate', as: :make_board_private


end
