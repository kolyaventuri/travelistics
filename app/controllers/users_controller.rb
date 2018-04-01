class UsersController < ApplicationController
  def show
    if session[:sid].nil?
      redirect_to login_path
    else
      @user = User.find(session[:user_id])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to account_path
    else
      unless @user.errors.details[:email].nil?
        flash[:error] = 'The provided email is already in use.'
      end
      redirect_to registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :email_confirmation,
      :password,
      :password_confirmation
    )
  end
end
