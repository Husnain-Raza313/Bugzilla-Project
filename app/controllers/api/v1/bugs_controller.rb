# frozen_string_literal: true

module Api
  module V1
    class BugsController < ApplicationController
      before_action :authenticate_user

      def index
        bugs = params[:query].present? ? Bug.search(params[:query],{fields: ['title'], match: :text_middle}) : Bug.all
        render json: bugs
      end

      def show
        bug = Bug.find_by(id: params[:id])
        if(bug.nil?)
          record_not_found;
        else
          render json: bug
        end
      end

      private
      def record_not_found
        render status: :not_found, json: {message: "Not found"}
      end
    end
  end
end
