# frozen_string_literal: true

class BugsController < ApplicationController
  # frozen_string_literal: true
  before_action :check_authorization, only: %i[destroy edit update]
  before_action :check_user, only: %i[new show]
  def index
    authorize Bug
    project_id = UserProject.where(user_id: current_user.id).pluck(:project_id)
    @bugs = Bug.where(project_id: project_id)
  end

  def show
    authorize Bug
  end

  def edit
    authorize Bug
  end

  def destroy
    authorize Bug
    @bug = Bug.find(params[:id])

    if @bug.destroy
      flash[:success] = 'Bug was successfully destroyed.'

    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end
    redirect_to assigned_bugs_path
  end

  def create
    @bug = Bug.new(bug_params)
    check_user
    authorize @bug, policy_class: BugPolicy
    respond_to do |format|
      if @bug.save
        format.html { redirect_to bug_url(@bug), flash: { success: 'Bug was successfully created.' } }
      else
        format.html { render 'bugs/new', status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @bug, policy_class: BugPolicy
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to bug_url(@bug.id), flash: { success: 'Bug was successfully updated.' } }
      else
        format.html { render 'bugs/edit', status: :unprocessable_entity }
      end
    end
  end

  def new
    @bug = Bug.new(project_id: params[:project_id])
    authorize @bug, policy_class: BugPolicy
    render 'bugs/new'
  end

  def assigned
    if current_user.qa?
      @bugs = Bug.where(user_id: current_user.id)
    elsif current_user.developer?
      @bugs = User.find(current_user.id).bugs
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def bug_params
    if current_user.developer?
      params.require(:bug).permit(:piece_status)
    else
      params.require(:bug).permit(:id, :piece_status, :description, :title, :project_id, :deadline, :screenshot,
                                  :piece_type).merge(user_id: current_user.id)
    end
  end

  def check_authorization
    if current_user.qa?
      check_qa
    elsif current_user.developer?
      check_dev
    end
  end

  def check_qa
    user_not_authorized if Bug.where(id: params[:id], user_id: current_user.id).take.nil?
    @bug = Bug.find(params[:id])
  end

  def check_dev
    user_not_authorized if BugUser.where(bug_id: params[:id], user_id: current_user.id).take.nil?
    @bug = Bug.find(params[:id])
  end

  def check_user
    project_id = @bug.nil? ? params[:project_id] : @bug.project_id
    if project_id.nil?
      check_show
    elsif UserProject.where(project_id: project_id, user_id: current_user.id).take.nil?
      user_not_authorized
    end
  end

  def check_show
    @bug = Bug.find(params[:id])
    user_not_authorized if UserProject.where(project_id: @bug.project_id, user_id: current_user.id).take.nil?
  end
end
