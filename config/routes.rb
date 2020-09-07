Rails.application.routes.draw do
  get "home/about" => "homes#about"
  root "homes#top"
  #get "home/top" => "homes{top"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  post "follow/:id" => "relationships#follow", as: "follow"
  post "unfollow/:id" => "relationships#unfollow", as: "unfollow"

  get "user/followings/:id" => "users#followings", as: "followings"
  get "user/followers/:id" => "users#followers", as: "followers"

  get "search" => "searches#search"
end
