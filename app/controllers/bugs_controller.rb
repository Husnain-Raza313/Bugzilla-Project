class BugsController < ApplicationController

  before_action :set_bug, only: %i[ edit update  new]


  def create
    @bug = Bug.new(bug_params)

    respond_to do |format|
      if @bug.save

        format.html { redirect_to bugs_show_url(@bug), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to bugs_show_url(@bug.id), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @bug = Bug.new(project_id: params[:project_id])
  end


  def set_bug
    @bug = Bug.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bug_params
    params.require(:bug).permit(:piece_status, :description, :title, :project_id, :deadline, :screenshot, :type)
  end

end
