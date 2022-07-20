# frozen_string_literal: true

class CodePiecesController < ApplicationController
  before_action :set_bug, only: %i[destroy show]
  before_action :check_bug, only: %i[edit]
  def index
    # @bugs=CodePiece.where.not(user_id: params[:id])
    # CodePiece.where(user_id!=).or(Book.where(category: "Ruby"))
    # admin_id=User.where(name: "Admin").pluck(:id)

    # @bugs=CodePiece.where.not(user_id: params[:id])
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
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to code_pieces_path, notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_bug
    @bug = CodePiece.find(params[:id])
  end

  def check_bug
    if current_user.developer?
      user = CodePieceUser.where(code_piece_id: params[:id]).pluck(:user_id)
      raise 'error' if user != current_user.id
    end

    @bug = CodePiece.find(params[:id])
  end
end
