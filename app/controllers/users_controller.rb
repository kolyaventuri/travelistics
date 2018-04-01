class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      unless @user.errors.details[:email].nil?
        flash[:reg_error] = 'The provided email is already in use.'
      end
      render :new
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
