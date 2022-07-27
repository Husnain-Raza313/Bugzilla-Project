# frozen_string_literal: true

class CodePiecesController < ApplicationController
  before_action :set_bug, only: %i[show destroy update]
  before_action :check_bug, only: %i[edit]

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
    @bug = CodePiece.new(project_id: params[:project_id])
    authorize @bug, policy_class: CodePiecePolicy
    render 'code_pieces/new'
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
    # Only allow a list of trusted parameters through.
    def bug_params
      if current_user.developer?
        params.require(:code_piece).permit(:piece_status)
      else
        params.require(:code_piece).permit(:piece_status, :description, :title, :project_id, :deadline, :screenshot, :piece_type)
      end
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
