class ApplicationController < ActionController::Base
  include SessionsHelper 
  before_action :set_locale

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def session_required
    redirect_to sign_in_user_path, notice: t('users.sign_in_first') unless user_signed_in?
  end
end
