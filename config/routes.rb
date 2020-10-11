Rails.application.routes.draw do
  devise_for :users
  root to: "blogs#index"
  
  resources :users

  resources :blogs do
   resources :comments, only: :create
    collection do 
     get "serch"
    end
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
