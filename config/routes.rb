Rails.application.routes.draw do
  root to: "top#index"
  get "about", to: "top#about"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :setting
      get :withdrawal
      get :password_resets
    end
    collection do
      get :search
    end
  end
  resources :events, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :search
    end
  end
end
