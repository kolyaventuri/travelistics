module SessionHelper
  def open_session(id)
    session[:user_id] = id
  end

  def require_login!
    return redirect_to login_path unless logged_in?
    @user = User.find(session[:user_id])
  end

  def logged_in?
    !session[:user_id].nil?
  end
end
