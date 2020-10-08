Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  devise_for :users
  resources :relationships, only: [:create, :destroy]
  resources :users,only: [:show,:index,:edit,:update]
  resources :books,only: [:show,:index,:create,:edit,:update,:destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

end