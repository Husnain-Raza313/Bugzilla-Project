module Api
  module V1
    class ApplicationController < ActionController::API
      include Knock::Authenticable
      undef_method :current_user

    end
  end
end
