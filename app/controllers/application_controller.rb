class ApplicationController < ActionController::Base
  helper CustomHelper
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authorized

  skip_before_action :authorized, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def logged_in?
    user_signed_in?
  end

  def authorized
    redirect_to new_user_session_path unless logged_in?
  end
end
