class UsersController < ApplicationController
  include SessionHelper

  def show
    require_login!
  end

  def new
    @user = User.new
  end

  def update
    if params[:id].to_i != session[:user_id]
      flash[:error] = 'You are not authorized to change that users password.'
      return redirect_to account_path
    end

    user = User.find(params[:id])

    if !User.authenticate(user.email, user_params[:current_password])
      flash[:error] = 'You must enter your current password first.'
    elsif user_params[:password] != user_params[:password_confirmation]
      flash[:error] = 'Passwords must match.'
    else
      user.update_password(user_params[:password])
      if user.save
        flash[:info] = 'Your password has been updated!'
      else
        flash[:error] = 'An error occured.'
      end
    end

    redirect_to account_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      open_session(@user.id)
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
      :password_confirmation,
      :current_password
    )
  end
end
