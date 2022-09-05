# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < V1::BaseController
      respond_to :json
      def index
        projects = Project.all
        respond_with projects
      end

      def show
        users = Project.find(params[:id]).users
        project = Project.find_by(id: params[:id])
        if project.nil?
          record_not_found
        else
          respond_with [project, users]
        end
      end

      private

      def record_not_found
        render status: :not_found, json: { message: 'Not found' }
      end
    end
  end
end
