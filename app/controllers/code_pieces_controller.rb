class CodePiecesController < ApplicationController

  before_action :set_bug, only: %i[ edit update  destroy show]
  def index
    # @bugs=CodePiece.where.not(user_id: params[:id])
    # CodePiece.where(user_id!=).or(Book.where(category: "Ruby"))
    # admin_id=User.where(name: "Admin").pluck(:id)

    # @bugs=CodePiece.where.not(user_id: params[:id])
    project_id= UserProject.where(user_id: current_user.id).pluck(:project_id)
    @bugs=CodePiece.where(project_id: project_id)
    puts @bugs.ids
  end
  def show

  end

  def edit
  end

  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to code_pieces_path, notice: "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def set_bug
    @bug = CodePiece.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bug_params
    params.require(:code_pieces).permit(:piece_status, :description, :title, :project_id, :deadline, :screenshot, :type)
  end

end
