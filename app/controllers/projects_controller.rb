# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
    authorize @projects
  end

  def show
    @userprojects = Project.find(params[:id]).users
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
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), flash: { success: 'Project was successfully created.' } }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @project

    respond_to do |format|
      if @project.update(project_params)

        format.html { redirect_to project_url(@project), flash: { success: 'Project was successfully updated.' } }
      else
        format.html { render :edit, status: :unprocessable_entity }

      end
    end
  end

  def destroy
    authorize @project
    if @project.destroy
      flash[:success] = 'Project was successfully destroyed.'
    else
      flash[:error] = @project.errors.full_messages.to_sentence
    end
    redirect_to projects_url(@project)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :id).merge(user_id: current_user.id)
  end
end
