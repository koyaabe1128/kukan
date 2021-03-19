module SessionsHelper
  
  #現在ログインしているユーザーを取得する
  def current_user
    if @current_user
      return @current_user
    else
      @current_user = User.find_by(id: session[:user_id])
      return @current_user
    end
  end
  
  #ユーザーがログインしているか確認する
  def logged_in?
    if current_user
      return true
    else
      return false
    end
  end
end
