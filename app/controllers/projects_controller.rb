# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
    authorize @projects
  end

  def show
    authorize @project
  end

  def new
    @project = Project.new
    authorize @project
  end

  def edit
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      flash[:success] = 'Project was successfully created.'
      redirect_to project_url(@project)
    else
      flash[:error] = "#{@project.errors}"
      render :new
    end
  end

  def update
    authorize @project

      if @project.update(project_params)
        flash[:success] = 'Project was successfully updated.'
        redirect_to project_url(@project)
      else
        flash[:error] = "#{@project.errors}"
        render :edit
      end

  end

  def destroy
    authorize @project

    if @project.destroy
      flash[:success] = 'Project was successfully destroyed.'
    else
      flash[:error] = "#{@project.errors}"
    end
    redirect_to projects_url(@project)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :id)
  end
end
