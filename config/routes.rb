Rails.application.routes.draw do
  devise_for :views
  devise_for :users
  root to: "blogs#index"
  resources :blogs
  resources :users
  resources :comments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
