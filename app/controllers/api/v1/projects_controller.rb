# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_user

      def index
        projects = Project.all
        render json: projects
      end

      def show

        project = Project.find_by(id: params[:id])
        if(project.nil?)
          record_not_found;
        else
          render json: project
        end

      end

      private
      def record_not_found
        render status: :not_found, json: {message: "Not found"}
      end

    end
  end
end
