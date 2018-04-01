class SessionsController < ApplicationController
  include SessionHelper

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
      open_session(user.id)
      redirect_to account_path
    end
  end

  def clear
    reset_session

    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end
