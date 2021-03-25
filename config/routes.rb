Rails.application.routes.draw do
  root to: "top#index"
  get "about", to: "top#about"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :followings
      get :likes
      get :setting
      get :withdrawal
      get :password_resets
    end
    collection do
      get :search
    end
  end
  resources :events do
      resources :likes, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  resources :relationships, only: [:create, :destroy]
  
end
