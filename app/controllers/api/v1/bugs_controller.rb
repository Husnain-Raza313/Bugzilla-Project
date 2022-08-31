# frozen_string_literal: true

module Api
  module V1
    class BugsController < ApplicationController
      respond_to :json
      def index
        bugs = Bug.all
        respond_with bugs
      end

      def show
        bug = Bug.find(params[:id])
        respond_with bug
      end
    end
  end
end
