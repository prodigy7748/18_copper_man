module SessionsHelper
  def current_user
    if session[:user_id].present?
      @_user ||= User.find_by(id: session[:user_id])
    else   
      nil
    end
  end

  def user_signed_in?
    if current_user
      true
    else
      false
    end
  end
end
