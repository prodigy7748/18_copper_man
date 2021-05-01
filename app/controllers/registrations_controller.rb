class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = params[:user][:id]
      redirect_to root_path, notice: '註冊成功！'
    else
      render :new
    end
  end

  private
    def user_params
        params.require(:user).permit(:email, :password, :name, :password_confirmation)
    end
end
