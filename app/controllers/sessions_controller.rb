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

    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end
