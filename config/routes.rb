Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:index] do
    resources :comments, only: [:destroy]
  end
  resources :users, only: [:index, :show] do
    resources :follows, only: [:create]
  end
  resources :listed_books, only: [:create]

  get 'books/:asin', to: 'books#show'
  delete 'follows', to: 'follows#destroy', as: 'user_follow'
  post 'books/comments/:asin', to: 'comments#create', as: 'books_comment'

  root 'books#index'
end
