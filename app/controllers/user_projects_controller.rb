# frozen_string_literal: true

class UserProjectsController < ApplicationController

  def index
    @projects = User.find(params[:user_id]).projects
    @user = User.find(params[:user_id])
    authorize @user
  end

  def show
    project = UserProject.where('user_id = ?', params[:id]).pluck('project_id')
    @user = User.find(params[:id])
    authorize @user, policy_class: UserProjectPolicy
    @userprojects = Project.where.not(id: project).where(user_id: current_user.id)
    render 'unassigned'
  end

  def create
    @userproject = UserProject.new(user_project_params)
    authorize @userproject

    if @userproject.save
      flash[:success] = 'Project was successfully Assigned.'
    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end
    redirect_to action: 'show', id: params[:user_id]
  end

  def destroy
    @project = UserProject.where(user_id: params[:user_id], project_id: params[:id]).take
    authorize @project
    flash[:success] = 'Project was successfully unassigned.' if UserProject.destroy(@project.id)
    redirect_to action: 'index', user_id: params[:user_id]
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
