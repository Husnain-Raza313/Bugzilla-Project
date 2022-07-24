# frozen_string_literal: true

class CodePieceUsersController < ApplicationController
  before_action :check_bug, only: %i[destroy]
  before_action :set_destroy_bug, only: %i[destroy]

  def index
    authorize CodePieceUser
    ids = CodePieceUser.where(user_id: current_user.id).pluck(:code_piece_id)
    @bugs = CodePiece.where.not(id: ids).where(project_id: params[:project_id])
    render 'unassigned'
  end

  def show
    authorize CodePieceUser
    ids = CodePieceUser.where(user_id: current_user.id).pluck(:code_piece_id)
    @bugs = CodePiece.where(id: ids, project_id: params[:id])

    render 'assigned'
  end

  def create
    authorize CodePieceUser
    bug1 = CodePiece.find(params[:code_piece_id])
    # CodePieceUser.create(code_piece_user_params)

    if CodePieceUser.create(code_piece_user_params)
      flash[:success] = 'Bug was successfully Assigned.'

    else
      flash[:error] = bug1.errors.full_messages.to_sentence
    end

    redirect_to action: 'index', project_id: bug1.project_id
  end

  def destroy
    authorize CodePieceUser
    project_id = CodePiece.where(id: params[:id]).pluck(:project_id)

    if CodePieceUser.destroy(@bug)
      flash[:success] = 'Bug was successfully unassigned.'

    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end

    redirect_to action: 'show', id: project_id
  end

  private

  def check_bug
    user = CodePieceUser.where(code_piece_id: params[:id]).pluck(:user_id)

    check_user unless current_user.id.in?(user)
  end

  # def create_check_bug
  #   user = CodePieceUser.where(code_piece_id: params[:code_piece_id]).pluck(:user_id)

  #     check_user unless current_user.id.in?(user)

  # end
  def set_destroy_bug
    @bug = CodePieceUser.where(code_piece_id: params[:id]).pluck(:id)
  end

  def check_user
    flash[:error] = 'You Are Not Authorized To Perform This Action'
    redirect_to authenticated_root_path
    nil
  end

  def code_piece_user_params
    params.permit(:user_id, :code_piece_id)
  end
end
