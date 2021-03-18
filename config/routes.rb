Rails.application.routes.draw do
  root to: "top#index"
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :setting
      get :withdrawal
      get :password_resets
    end
  end
end
