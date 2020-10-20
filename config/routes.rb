Rails.application.routes.draw do
 devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  } 
  root to: "blogs#index"
  
  resources :users, only: [:index, :new, :create, :edit, :destroy, :show]

  resources :blogs do
   resources :comments, only: :create
    collection do 
     get "search"
    end
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
