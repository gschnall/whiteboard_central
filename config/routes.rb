Rails.application.routes.draw do
  root 'sessions#new'

  get '/logout' => 'sessions#destroy', as: :logout
  get 'signup' => 'users#new', as: :signup
  resources :sessions, only: [:new, :create]

  delete 'users/:id' => 'users#destroy', as: :users_destroy
  get 'users/index' => 'users#index', as: :search_users
  resources :users

  get 'boards/show' => 'boards#show', as: :public_boards
  delete 'boards/:id' => 'boards#destroy', as: :boards_destroy
  get 'boards/index' => 'boards#index', as: :search_boards
  resources :boards
  get 'boards/:id/private' => 'boards#makePrivate', as: :make_board_private
  get 'boards/:id/updateBoard' => 'boards#editInfo', as: :edit_board_info
  patch 'boards/:id/updateBoard' => 'boards#updateInfo', as: :update_board_info

end
