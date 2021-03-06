class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :full_name
    devise_parameter_sanitizer.for(:sign_up) << { attachment_attributes: [:id, :image, :_destroy] }
  end

  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :full_name
    devise_parameter_sanitizer.for(:account_update) << { attachment_attributes: [:id, :image, :_destroy] }
  end
end
