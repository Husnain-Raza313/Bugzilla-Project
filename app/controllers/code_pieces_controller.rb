# frozen_string_literal: true

class CodePiecesController < ApplicationController
  before_action :check_authorization, only: %i[show destroy edit update]
  before_action :check_user, only: %i[new]
  def index
    authorize CodePiece
    project_id = UserProject.where(user_id: current_user.id).pluck(:project_id)
    @bugs = CodePiece.where(project_id: project_id)
  end

  def show
    authorize CodePiece
  end

  def edit
    authorize CodePiece
  end

  def destroy
    authorize CodePiece
    @bug = CodePiece.find(params[:id])

    if @bug.destroy
      flash[:success] = 'Bug was successfully destroyed.'

    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end
    redirect_to code_pieces_path
  end

  def create
    @bug = CodePiece.new(bug_params)
    check_user
    authorize @bug, policy_class: CodePiecePolicy
    respond_to do |format|
      if @bug.save
        format.html { redirect_to code_piece_url(@bug), flash: { success: 'Bug was successfully created.' } }
      else
        format.html { render 'code_pieces/new', status: :unprocessable_entity }
      end
    end
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
  end

  def new
    @bug = CodePiece.new(project_id: params[:project_id])
    authorize @bug, policy_class: CodePiecePolicy
    render 'code_pieces/new'
  end

  private

  # Only allow a list of trusted parameters through.
  def bug_params
    if current_user.developer?
      params.require(:code_piece).permit(:piece_status)
    else
      params.require(:code_piece).permit(:id, :piece_status, :description, :title, :project_id, :deadline, :screenshot,
                                         :piece_type).merge(user_id: current_user.id)
    end
  end

  def check_authorization
    if current_user.qa?
      check_qa
    elsif current_user.developer?
      check_dev
    end
  end

  def check_qa
    user_not_authorized if CodePiece.where(id: params[:id], user_id: current_user.id).take.nil?
    @bug = CodePiece.find(params[:id])
  end

  def check_dev
    user_not_authorized if CodePieceUser.where(code_piece_id: params[:id], user_id: current_user.id).take.nil?
    @bug = CodePiece.find(params[:id])
  end

  def check_user
    project_id = params[:project_id].nil? ? @bug.project_id : params[:project_id]
    user_not_authorized if UserProject.where(project_id: project_id, user_id: current_user.id).take.nil?
  end
end
