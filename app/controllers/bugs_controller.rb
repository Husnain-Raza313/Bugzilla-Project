# frozen_string_literal: true

class BugsController < ApplicationController
  # frozen_string_literal: true
  before_action :check_authorization, only: %i[destroy edit update]
  before_action :check_user, only: %i[new show]
  before_action :bug_params, only: %i[update]
  def index
    authorize Bug
    dev_index if params[:project_id].present?
    project_id = UserProject.where(user_id: current_user.id).pluck(:project_id)
    @bugs = Bug.where(project_id: project_id)
  end

  def dev_index
    unless check_project
      @bugs = Bug.where.not(id: bug_found).where(project_id: params[:project_id])
      render 'bug_users/unassigned'
    end
  end

  def dev_show
    # authorize BugUser
    # ids = BugUser.where(user_id: current_user.id).pluck(:bug_id)
    unless check_project
      @bugs = Bug.where(id: bug_found, project_id: params[:id])
      render 'bug_users/assigned'
    end
  end

  def dev_create
    unless check_dev_create
      @bug = Bug.find(params[:project_id])
      dev = @bug.developer_ids unless @bug.developer_ids.nil?
      dev.push(current_user.id)
      if @bug.update(developer_ids: dev)
        flash[:success] = 'Bug was successfully Assigned.'

      else
        flash[:error] = @bug.errors.full_messages.to_sentence
      end

      redirect_to project_bugs_path(@bug.project_id)
    end
  end

  def dev_destroy
    project_id = Bug.where(id: params[:id]).pluck(:project_id)
    @bug = Bug.find(params[:id])
    dev = @bug.developer_ids
    dev.delete(current_user.id.to_s)

    if @bug.update(developer_ids: dev)
      flash[:success] = 'Bug was successfully unassigned.'

    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end

    redirect_to assigned_bugs_path(project_id)
  end

  def show
    authorize Bug
    @bug = Bug.find(params[:id])
  end

  def edit
    authorize Bug
    @bug = Bug.find(params[:id])
  end

  def destroy
    authorize Bug
    if current_user.developer?
      dev_destroy
    else
      @bug = Bug.find(params[:id])

      if @bug.destroy
        flash[:success] = 'Bug was successfully destroyed.'

      else
        flash[:error] = @bug.errors.full_messages.to_sentence
      end
      redirect_to assigned_bugs_path
    end
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
    authorize Bug
    @bug = Bug.find(params[:id])
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to bug_url(@bug.id), flash: { success: 'Bug was successfully updated.' } }
      else
        format.html { render 'bugs/edit', status: :unprocessable_entity }
      end
    end
  end

  def new
    if current_user.developer?
      dev_create
    else
      authorize Bug
      @bug = Bug.new(project_id: params[:project_id])
      render 'bugs/new'
    end
  end

  def assigned
    authorize Bug
    if current_user.qa?
      @bugs = Bug.where(qa_id: current_user.id)
    elsif current_user.developer?
      params[:id] == 'list' ? @bugs = Bug.where(id: bug_found) : dev_show
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def bug_params
    if current_user.developer?
      params.require(:bug).permit(:piece_status)
    else
      params.require(:bug).permit(:id, :piece_status, :description, :title, :project_id, :deadline, :screenshot,
                                  :piece_type).merge(qa_id: current_user.id)
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
    @bug = Bug.find(params[:id])
    user_not_authorized if Bug.where(id: params[:id], qa_id: current_user.id).take.nil?
  end

  def check_dev
    @bug = Bug.find(params[:id])
    user_not_authorized unless @bug.developer_ids.include?(current_user.id.to_s)
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

  def bug_found
    ids = []
    @bugs = Bug.all

    @bugs.sort.each do |bug|
      ids.push(bug.id) if bug.developer_ids.include?(current_user.id.to_s)
    end

    ids
  end

  def check_dev_create
    id = Bug.where(id: params[:project_id]).pluck(:project_id)
    user_not_authorized if UserProject.where(project_id: id, user_id: current_user.id).take.nil?
  end

  def check_project
    project_id = params[:project_id].nil? ? params[:id] : params[:project_id]
    user_not_authorized if UserProject.where(project_id: project_id, user_id: current_user.id).take.nil?
  end
end
