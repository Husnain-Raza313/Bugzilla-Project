# frozen_string_literal: true

class CodePiecesController < ApplicationController
  before_action :set_bug, only: %i[show destroy]
  before_action :check_bug, only: %i[edit]
  def index
    authorize CodePiece
    project_id = UserProject.where(user_id: current_user.id).pluck(:project_id)
    puts "hello my #{project_id[0]}"
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

  private

  def set_bug
    # project_ids = CodePiece.where(id: params[:id]).pluck(:project_id)
    # user = UserProject.where(project_id: project_ids).pluck(:user_id)
    # unless current_user.id.in?(user)
    #   flash[:error] = 'You Are Not Authorized To Perform This Action'
    #   redirect_to authenticated_root_path
    #   return
    # end
    # if params[:id].nil?
    # @bug=CodePiece.find(@bug.id)

    # else
    @bug = CodePiece.find(params[:id])
    # end

  end

  def check_bug
    if current_user.qa?
      set_bug
    else
      user = CodePieceUser.where(code_piece_id: params[:id]).pluck(:user_id)
      check_user unless current_user.id.in?(user)

      @bug = CodePiece.find(params[:id])
    end
  end

  def check_user
    flash[:error] = 'You Are Not Authorized To Perform This Action'
    redirect_to authenticated_root_path
    nil
  end
end
