Rails.application.routes.draw do
 devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  } 
  devise_scope :user do
    get 'users/index', to: 'users/registrations#index'
    get 'users/destroy', to: 'users/sessions#destroy'
    put 'users/password/new', to: 'users/passwords#new'
    get 'users/password', to: 'users/passwords#edit'
    put 'users/password', to: 'users/passwords#update'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest' #ゲストログイン用
  end 

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  
  root to: "blogs#index"
  
  resources :users, only: [:index, :new, :create, :show] do
    resources :relationships
    collection do
      get "follower"
    end
  end

  resources :blogs do
    collection do
      get 'confirm' 
    end
   resources :comments, only: :create
    collection do 
     get "search"
    end
  end  

  resources :rooms, only: [:index, :new, :create, :show, :destroy] do
    resources :messages, only: [:index, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
