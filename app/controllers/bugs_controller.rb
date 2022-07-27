# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[update]

  def create
    @bug = Bug.new(bug_params)
    authorize @bug, policy_class: CodePiecePolicy
    respond_to do |format|
      if @bug.save
        format.html { redirect_to code_piece_url(@bug), flash: { success: 'Bug was successfully created.' } }
      else
        format.html { render 'code_pieces/new', status: :unprocessable_entity }
      end
    end

    # if @bug.save
    #   flash[:success] = 'Bug was successfully Created'
    #   redirect_to code_piece_url(@bug)
    # else
    #   flash[:error] = @bug.errors.full_messages.to_sentence
    #   redirect_to action: 'new', project_id: @bug.project_id
    # end
  end

  def update
    authorize @bug, policy_class: CodePiecePolicy
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to code_piece_url(@bug.id), flash: { success: 'Bug was successfully updated.' } }
      else
        format.html { render 'code_pieces/edit', status: :unprocessable_entity }
      end
    end

    # if @bug.update(bug_params)
    #   flash[:success] = 'Bug was successfully updated.'
    #   redirect_to code_piece_url(@bug.id)
    # else
    #   flash[:error] = @bug.errors.full_messages.to_sentence
    #   redirect_to action: 'edit', controller: 'code_pieces', id: params[:id]
    # end
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
      params.require(:bug).permit(:id, :piece_status, :description, :title, :project_id, :deadline, :screenshot, :type)
    end
  end
end
