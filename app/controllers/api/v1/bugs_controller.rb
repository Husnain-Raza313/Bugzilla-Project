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
        bug = Bug.find_by(id: params[:id])
        if(bug.nil?)
          record_not_found;
        else
          respond_with bug
        end
      end

      private
      def record_not_found
        render status: :not_found, json: {message: "Not found"}
      end
    end
  end
end
