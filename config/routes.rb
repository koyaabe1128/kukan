Rails.application.routes.draw do
  root to: "top#index"
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
  end
end
