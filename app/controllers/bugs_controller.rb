# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :check_user, only: %i[show]
  before_action :bug_params, only: %i[update]
  before_action :set_bug, only: %i[destroy edit update]
  def index
    authorize Bug
    case params[:status]
    when 'all'
      project_id = UserProject.where(user_id: current_user.id).pluck(:project_id)
      @bugs = Bug.where(project_id: project_id)
    when 'assigned'
      @bugs = Bug.where(qa_id: current_user.id)
      render 'assigned' and return
    end
  end

  def show
    authorize Bug
  end

  def edit
    authorize @bug
  end

  def destroy
    authorize @bug
    if @bug.destroy
      flash[:success] = 'Bug was successfully destroyed.'
    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end
    redirect_to bugs_path(status: 'assigned')
  end

  def create
    authorize Bug
    @bug = Bug.new(bug_params)
    check_user
    respond_to do |format|
      if @bug.save
        format.html { redirect_to bug_url(@bug), flash: { success: 'Bug was successfully created.' } }
      else
        format.html { render 'bugs/new', status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @bug
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to bug_url(@bug.id), flash: { success: 'Bug was successfully updated.' } }
      else
        format.html { render 'bugs/edit', status: :unprocessable_entity }
      end
    end
  end

  def new
    return if check_user

    authorize Bug
    @bug = Bug.new(project_id: params[:project_id])
    render 'bugs/new'
  end

  private

  def bug_params
    if current_user.developer?
      params.require(:bug).permit(:piece_status)
    else
      params.require(:bug).permit(:id, :piece_status, :description, :title, :project_id, :deadline, :screenshot,
                                  :piece_type).merge(qa_id: current_user.id)
    end
  end

  def check_user
    project_id = @bug.nil? ? params[:project_id] : @bug.project_id
    if project_id.nil?
      set_bug
      user_authorization(@bug.project_id)
    else
      user_authorization(project_id)
    end
  end

  def user_authorization(id)
    user_not_authorized if UserProject.where(project_id: id, user_id: current_user.id).take.nil?
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end
end
