module Api
  module V1
    class ProjectsController < ApplicationController
      respond_to :json
      def index
        projects = Project.all
        respond_with projects
      end
      def show
        users = Project.find(params[:id]).users
        project = Project.find(params[:id])
        respond_with [project, users]
      end
    end
  end
end
