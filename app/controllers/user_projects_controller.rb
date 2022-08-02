# frozen_string_literal: true

class UserProjectsController < ApplicationController
  # around_action :check_authorization , only: %i[ index unassigned]

  def index
    # shows assigned projects
    @projects = User.find(params[:user_id]).projects
    @user = User.find(params[:user_id])
    authorize @user
  end

  def show
    # shows unassigned Projects
    project = UserProject.where('user_id = ?', params[:id]).pluck('project_id')
    # using it in views
    @user = User.find(params[:id])
    authorize @user, policy_class: UserProjectPolicy
    @userprojects = Project.where.not(id: project).where(user_id: current_user.id)
    render 'unassigned'
  end

  def create
    @userproject = UserProject.new(user_project_params)
    authorize @userproject
    @userproject.save
    redirect_to action: 'show', id: params[:user_id]
  end

  def destroy
    @project = UserProject.where(user_id: params[:user_id], project_id: params[:id]).take
    authorize @project
    UserProject.destroy(@project.id)
    redirect_to action: 'index', id: params[:user_id]
  end

  def view_projects
    authorize UserProject
    @projects = UserProject.where(user_id: current_user.id)

    render 'view_projects'
  end

  def user_project_params
    params.permit(:user_id, :project_id, :name, :manager_id)
  end
end
