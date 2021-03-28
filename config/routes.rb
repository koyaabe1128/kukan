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
#投稿一覧に注目のイベントを入れる、いいねの数が１日で多い順番でセレクトする
#投稿詳細ページはやっぱり一列で幅が狭い方が楽なのかも
#検索結果の一覧は、注目のイベントなどを入れないようにするために別のページを用意した方がいいかも
#投稿する、いいね機能、探す機能、ユーザー情報登録はログインまたは新規登録を要するようにする、していなくてもある程度の機能は使用できるようにする
