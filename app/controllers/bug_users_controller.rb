# frozen_string_literal: true

class BugUsersController < ApplicationController
  # frozen_string_literal: true
  before_action :check_bug, only: %i[destroy]
  before_action :create_check_bug, only: %i[create]
  before_action :set_destroy_bug, only: %i[destroy]
  before_action :check_project, only: %i[index show]

  def index
    authorize BugUser
    ids = BugUser.where(user_id: current_user.id).pluck(:bug_id)
    @bugs = Bug.where.not(id: ids).where(project_id: params[:project_id])
    render 'unassigned'
  end

  def show
    authorize BugUser
    ids = BugUser.where(user_id: current_user.id).pluck(:bug_id)
    @bugs = Bug.where(id: ids, project_id: params[:id])

    render 'assigned'
  end

  def create
    authorize BugUser
    @bug = Bug.find(params[:bug_id])

    if BugUser.create(bug_user_params)
      flash[:success] = 'Bug was successfully Assigned.'

    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end

    redirect_to action: 'index', project_id: @bug.project_id
  end

  def destroy
    authorize BugUser
    project_id = Bug.where(id: params[:id]).pluck(:project_id)

    if BugUser.destroy(@bug)
      flash[:success] = 'Bug was successfully unassigned.'

    else
      flash[:error] = @bug.errors.full_messages.to_sentence
    end

    redirect_to action: 'show', id: project_id
  end

  private

  def check_bug
    user_not_authorized if BugUser.where(bug_id: params[:id], user_id: current_user.id).take.nil?
  end

  def create_check_bug
    project_id = Bug.where(id: params[:bug_id]).pluck(:project_id)
    user_not_authorized if UserProject.where(project_id: project_id, user_id: current_user.id).take.nil?
  end

  def set_destroy_bug
    @bug = BugUser.where(bug_id: params[:id]).pluck(:id)
  end

  def check_user
    flash[:error] = 'You Are Not Authorized To Perform This Action'
    redirect_to authenticated_root_path
    nil
  end

  def bug_user_params
    params.permit(:user_id, :bug_id)
  end

  def check_project
    project_id = params[:project_id].nil? ? params[:id] : params[:project_id]

    user_not_authorized if UserProject.where(project_id: project_id, user_id: current_user.id).take.nil?
  end
end
