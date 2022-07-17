class CodePiecesController < ApplicationController

  before_action :set_bug, only: %i[ edit update  ]
  def index
    # @bugs=CodePiece.where.not(user_id: params[:id])
    # CodePiece.where(user_id!=).or(Book.where(category: "Ruby"))
    # admin_id=User.where(name: "Admin").pluck(:id)

    # @bugs=CodePiece.where.not(user_id: params[:id])
    @bugs=CodePiece.all
    puts @bugs.ids
  end
  def show
    @bug = CodePiece.find(params[:id])
  end

  def edit
  end

  def set_bug
    @bug = CodePiece.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bug_params
    params.require(:code_pieces).permit(:piece_status, :description, :title, :project_id, :deadline, :screenshot, :type)
  end

end
