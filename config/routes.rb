Rails.application.routes.draw do
  root 'boards#index'
  resources :sessions, only: [:new, :create, :destroy]

  delete 'users/:id' => 'users#destroy', as: :users_destroy
  resources :users

  delete 'boards/:id' => 'boards#destroy', as: :boards_destroy
  resources :boards

end
