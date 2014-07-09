Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:index]
  resources :users, only: [:index, :show]
  resources :listed_books, only: [:create]

  get 'books/:asin', to: 'books#show'


  root 'books#index'
end
