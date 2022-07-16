class CodePiecesController < ApplicationController

  before_action :set_bug, only: %i[ edit update  ]
  def index
    # @bugs=CodePiece.where.not(user_id: params[:id])
    # CodePiece.where(user_id!=).or(Book.where(category: "Ruby"))
    @bugs=CodePiece.where.not(user_id: params[:id]).or(CodePiece.where(user_id: nil))
    puts @bugs.ids
  end
  def unassigned
    bug_titles=CodePiece.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    @bugs=CodePiece.where(:project_id => params[:id]).where.not(:title => bug_titles)

  end
  def assigned
    bug_titles=CodePiece.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    @bugs=CodePiece.where(:project_id => params[:id],:title => bug_titles,user_id: params[:userid])

  end
  def assign
    bug1=CodePiece.find(params[:id])
    dup_bug=CodePiece.find(params[:id]).dup
    # bug=CodePiece.find(params[:id]).dup
    # bug.save

    bug1.update(user_id: params[:userid])
    # CodePiece.create(dup_bug)
    dup_bug.save

    puts"DUP BUG has USER IDDDD  #{dup_bug.user_id}"

  #  @bug.update(user_id: @bug.user_id)
    # user.projects << project
    redirect_to action: 'unassigned', userid: params[:userid], id: bug1.project_id
  end
  def remove
    project_id=CodePiece.where(id: params[:id]).pluck(:project_id)
    CodePiece.destroy(params[:id])

  #  @bug.update(user_id: @bug.user_id)
    # user.projects << project
    redirect_to action: 'assigned', userid: params[:userid], id: project_id
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
    params.require(:code_pieces).permit(:piece_status, description)
  end

end
