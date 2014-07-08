Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:index]
  root 'books#index'
end
