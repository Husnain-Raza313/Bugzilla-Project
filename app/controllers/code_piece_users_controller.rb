# frozen_string_literal: true

class CodePieceUsersController < ApplicationController
  before_action :check_bug, only: %i[destroy]
  # before_action :create_check_bug, only: %i[create]

  def index
    # bug_titles=CodePiece.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    # @bugs=CodePiece.where(:project_id => params[:id]).where.not(:title => bug_titles)

    # admin_id=User.where(name: "Admin").pluck(:id)

    authorize CodePieceUser
    ids = CodePieceUser.where(user_id: current_user.id).pluck(:code_piece_id)
    @bugs = CodePiece.where.not(id: ids).where(project_id: params[:project_id])
    render 'unassigned'
  end

  def show
    # bug_titles=CodePiece.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    # @bugs=CodePiece.where(:project_id => params[:id],:title => bug_titles,user_id: params[:userid])

    # @bugs=CodePiece.where(user_id: params[:userid],project_id: params[:id])

    # @bugs=CodePieceUsers.where(user_id: params[:id])
    # @bugs=CodePiece.where.not(id: bugs.ids)

    # prints unassigned bugs
    authorize CodePieceUser
    ids = CodePieceUser.where(user_id: current_user.id).pluck(:code_piece_id)
    @bugs = CodePiece.where(id: ids, project_id: params[:id])

    render 'assigned'
  end

  def create
    authorize CodePieceUser
    bug1 = CodePiece.find(params[:code_piece_id])

    CodePieceUser.create(code_piece_user_params)
    # bug1.update(user_id: params[:userid])
    # CodePiece.create(dup_bug)
    # dup_bug.save

    # puts"DUP BUG has USER IDDDD  #{dup_bug.user_id}"

    #  @bug.update(user_id: @bug.user_id)
    # user.projects << project

    redirect_to action: 'index', project_id: bug1.project_id
  end

  def destroy
    authorize CodePieceUser
    project_id = CodePiece.where(id: params[:id]).pluck(:project_id)
    # # CodePiece.destroy(params[:id])
    # @bug=CodePiece.where(id: params[:id])
    # admin_id=User.where(name: "Admin").pluck(:id)
    # @bug.update(user_id: 3)
    #  @bug.update(user_id: @bug.user_id)
    # user.projects << project

    bug = CodePieceUser.where(code_piece_id: params[:id]).pluck(:id)
    CodePieceUser.destroy(bug)

    redirect_to action: 'show', id: project_id
  end

  # def show
  #   authorize CodePieceUser
  #   @bug = CodePiece.find(params[:id])
  # end
  private

  def check_bug
    user = CodePieceUser.where(code_piece_id: params[:id]).pluck(:user_id)

    check_user unless current_user.id.in?(user)
  end

  # def create_check_bug
  #   user = CodePieceUser.where(code_piece_id: params[:code_piece_id]).pluck(:user_id)

  #     check_user unless current_user.id.in?(user)

  # end

  def check_user
    flash[:error] = 'You Are Not Authorized To Perform This Action'
    redirect_to authenticated_root_path
    nil
  end

  def code_piece_user_params
    params.permit(:user_id, :code_piece_id)
  end
end
