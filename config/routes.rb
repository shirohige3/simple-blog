Rails.application.routes.draw do
 devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  } 
  devise_scope :user do
    get 'users/index', to: 'users/registrations#index'
    get 'users/destroy', to: 'users/sessions#destroy'
    get 'registrations/edit_password', to: 'registrations#edit_password', as: 'edit_password'
    put 'registrations/update_password', to: 'registrations#update_password', as: 'update_password'
  end 
  
  root to: "blogs#index"
  
  resources :users, only: [:index, :new, :create, :show] 

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
