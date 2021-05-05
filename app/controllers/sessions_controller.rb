class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.login(params[:user])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: t('users.sign_in_successfully')
    else
      redirect_to sign_in_user_path, notice: t('users.sign_in_failed')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('users.sign_in_failed')
  end
end
