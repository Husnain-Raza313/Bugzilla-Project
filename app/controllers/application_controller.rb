# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protect_from_forgery with: :null_session, if: -> { request.format.json? }

  # wrap_parameters false


  include Pundit::Authorization



  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::UnknownFormat, with: :page_not_found

  protected

  def configure_permitted_parameters
    puts "IM IN FORMATTTT"
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])

    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password user_type])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password user_type current_password])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: authenticated_root_path)
  end

  def record_not_found(error)
    flash[:error] = error.message
    redirect_back(fallback_location: authenticated_root_path)
  end

  def page_not_found(_error)
    flash[:error] = 'SORRY!!! PAGE NOT FOUND'
    redirect_back(fallback_location: authenticated_root_path)
  end
end
