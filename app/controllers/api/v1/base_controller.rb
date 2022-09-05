class Api::V1::BaseController < ApplicationController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters
  puts"IM IN BASE CONTROLLER"
  devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
end
end
