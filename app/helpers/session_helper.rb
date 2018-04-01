module SessionHelper
  def open_session(id)
    session[:user_id] = id
    sid = rand(36**64).to_s(36)
    session[:sid] = sid
    cookies[:sid] = sid
  end

  def require_login!
    return redirect_to login_path unless logged_in?
    @user = User.find(session[:user_id])
  end

  def logged_in?
    !session[:sid].nil?
  end
end
