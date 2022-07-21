# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[update]

  def create
    @bug = Bug.new(bug_params)
    authorize @bug, policy_class: CodePiecePolicy

    if @bug.save
      flash[:success] = 'Bug was successfully Created'
      redirect_to code_piece_url(@bug)
    else
      flash[:error] = @bug.errors
      render :new
    end
  end

  def update
    authorize @bug, policy_class: CodePiecePolicy
    if @bug.update(bug_params)
      flash[:success] = 'Bug was successfully updated.'
      redirect_to code_piece_url(@bug.id)
    else
      flash[:error] = @bug.errors
      render :edit
    end
  end

  def new
    @bug = Bug.new(project_id: params[:project_id])
    authorize @bug, policy_class: CodePiecePolicy
    render 'code_pieces/new'
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bug_params
    if current_user.developer?
      params.require(:bug).permit(:piece_status)
    else
      params.require(:bug).permit(:piece_status, :description, :title, :project_id, :deadline, :screenshot, :type)
    end
  end
end
