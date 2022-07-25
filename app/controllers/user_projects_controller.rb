# frozen_string_literal: true

class UserProjectsController < ApplicationController
  # around_action :check_authorization , only: %i[ index unassigned]

  def index
    @projects = User.find(params[:user_id]).projects
    @user = User.find(params[:user_id])

    authorize @user
  end

  def show
    # shows unassigned Projects
    project = UserProject.where('user_id = ?', params[:id]).pluck('project_id')
    @user = User.find(params[:id])

    @userprojects = Project.where.not(id: project)
    authorize @user, policy_class: UserProjectPolicy
    # @projects=Project.eager_load(:users).where('forms.kind = "health"')
    render 'unassigned'
  end

  def create
    authorize UserProject

    @userproject = UserProject.create(user_project_params)
    redirect_to action: 'show', id: params[:user_id]
  end

  def destroy
    authorize UserProject

    project = UserProject.where(user_id: params[:user_id], project_id: params[:id])
    UserProject.destroy(project.ids)
    redirect_to action: 'index', id: params[:user_id]
  end

  def view_projects
    authorize UserProject
    @projects = UserProject.where(user_id: params[:id])

    render 'view_projects'
  end

  def user_project_params
    params.permit(:user_id, :project_id, :name)
  end
end
