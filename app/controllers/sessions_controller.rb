class SessionsController < ApplicationController
  def login
    @user = User.new
  end

  def authenticate
    params = user_params
    user = User.authenticate(params[:email], params[:password])
    if user.nil?
      flash[:error] = 'Your email or password was incorrect.'
      redirect_to :login
    else
      session[:user_id] = user.id
      sid = generate_sid
      session[:sid] = sid
      cookies[:sid] = sid
      redirect_to '/register'
    end
  end

  private
  def generate_sid
    rand(36**64).to_s(36)
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end
