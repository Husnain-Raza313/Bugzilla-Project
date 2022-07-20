class ProjectsController < ApplicationController

  before_action :set_project, only: %i[ show edit update destroy ]


  def index
    @projects= Project.all
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

      respond_to do |format|
        if @project.save

          format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end


    def update
        authorize @project
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end


    def destroy
      authorize @project
      @project.destroy

      respond_to do |format|
        format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
        format.json { head :no_content }
      end
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
