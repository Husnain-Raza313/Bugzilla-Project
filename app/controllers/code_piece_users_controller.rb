class CodePieceUsersController < ApplicationController
  def unassigned
    # bug_titles=CodePiece.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    # @bugs=CodePiece.where(:project_id => params[:id]).where.not(:title => bug_titles)

    # admin_id=User.where(name: "Admin").pluck(:id)

    # @bugs=CodePiece.where.not(user_id: params[:userid]).or(CodePiece.where(user_id: admin_id, project_id: params[:id]))
    authorize CodePieceUser
    ids=CodePieceUser.where(user_id: params[:userid]).pluck(:code_piece_id)
    @bugs=CodePiece.where.not(id: ids).where(project_id: params[:id])
  end
  def assigned
    # bug_titles=CodePiece.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    # @bugs=CodePiece.where(:project_id => params[:id],:title => bug_titles,user_id: params[:userid])

    # @bugs=CodePiece.where(user_id: params[:userid],project_id: params[:id])

    # @bugs=CodePieceUsers.where(user_id: params[:id])
    # @bugs=CodePiece.where.not(id: bugs.ids)
    authorize CodePieceUser
    ids=CodePieceUser.where(user_id: params[:userid]).pluck(:code_piece_id)
    @bugs=CodePiece.where(:id => ids , :project_id => params[:id])

  end
  def assign
    authorize CodePieceUser
    bug1=CodePiece.find(params[:id])
    # # dup_bug=CodePiece.find(params[:id]).dup
    # # # bug=CodePiece.find(params[:id]).dup
    # # # bug.save
    CodePieceUser.create(user_id: params[:userid], code_piece_id: params[:id])
    # bug1.update(user_id: params[:userid])
    # CodePiece.create(dup_bug)
    # dup_bug.save

    # puts"DUP BUG has USER IDDDD  #{dup_bug.user_id}"

  #  @bug.update(user_id: @bug.user_id)
    # user.projects << project

    redirect_to action: 'unassigned', userid: params[:userid], id: bug1.project_id
  end
  def remove
    authorize CodePieceUser
    project_id=CodePiece.where(id: params[:id]).pluck(:project_id)
    # # CodePiece.destroy(params[:id])
    # @bug=CodePiece.where(id: params[:id])
    # admin_id=User.where(name: "Admin").pluck(:id)
    # @bug.update(user_id: 3)
    #  @bug.update(user_id: @bug.user_id)
    # user.projects << project

    bug=CodePieceUser.find_by(code_piece_id: params[:id])
    CodePieceUser.destroy(bug.id)

    redirect_to action: 'assigned', userid: params[:userid], id: project_id
  end
  def show
    authorize CodePieceUser
    @bug = CodePiece.find(params[:id])
  end
end
