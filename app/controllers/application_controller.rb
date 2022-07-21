# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password,:user_type) }

    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password user_type])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password user_type current_password])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: authenticated_root_path)
  end
end
