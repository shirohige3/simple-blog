Rails.application.routes.draw do
 devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  } 
  devise_scope :user do
    get 'users/index', to: 'users/registrations#index'
    get 'users/destroy', to: 'users/sessions#destroy'
  end 
  
  root to: "blogs#index"
  
  resources :users, only: [:index, :new, :create, :edit, :show]

  resources :blogs do
    collection do
      get 'confirm'
    end
   resources :comments, only: :create
    collection do 
     get "search"
    end
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
