Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:index]
  resources :users, only: [:index, :show]
  root 'books#index'
end
