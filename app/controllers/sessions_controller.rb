class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.login(params[:user])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: '登入成功'
    else
      redirect_to sign_in_users_path, notice: '登入失敗'
    end
  end
end
