# frozen_string_literal: true

module Developer
  class BugsController < Developer::BaseController
    before_action :set_bug, only: %i[destroy]
    before_action :check_project, only: %i[project_bugs]

    def index
      authorize([:developer, Bug])
      case params[:status]
      when 'all'
        project_id = UserProject.where(user_id: current_user.id).pluck(:project_id)
        @bugs = Bug.where(project_id: project_id)
        render 'bugs/index' and return
      when 'assigned'
        @bugs = Bug.where(id: bug_found)
        render 'bugs/assigned' and return
      end
    end

    def project_bugs
      case params[:status]
      when 'unassigned'
        @bugs = Bug.where.not(id: bug_found).where(project_id: params[:project_id])
        render 'unassigned' and return
      when 'assigned'
        @bugs = Bug.where(id: bug_found, project_id: params[:project_id])
        render 'project_bugs' and return
      end
    end

    def new
      authorize([:developer, Bug])
      return if check_dev_new

      @bug = Bug.find(params[:id])
      return unless add_id

      flash[:success] = 'Bug was successfully Assigned.'
      redirect_to project_bugs_path(@bug.project_id, status: 'unassigned')
    end

    def destroy
      authorize([:developer, @bug])
      project_id = Bug.where(id: params[:id]).pluck(:project_id)
      if delete_id
        flash[:success] = 'Bug was successfully unassigned.'
      else
        flash[:error] = @bug.errors.full_messages.to_sentence
      end
      redirect_to project_bugs_path(project_id, status: 'assigned')
    end

    private

    def bug_found
      ids = []
      @bugs = Bug.all
      @bugs.sort.each do |bug|
        ids.push(bug.id) if bug.developer_ids.include?(current_user.id.to_s)
      end
      ids
    end

    def check_dev_new
      id = Bug.where(id: params[:id]).pluck(:project_id)
      user_authorization(id)
    end

    def check_project
      authorize([:developer, Bug])
      project_id = params[:project_id]
      user_authorization(project_id)
    end

    def user_authorization(id)
      user_not_authorized if UserProject.where(project_id: id, user_id: current_user.id).take.nil?
    end

    def set_bug
      @bug = Bug.find(params[:id])
    end

    def delete_id
      @bug.developer_ids.delete(current_user.id.to_s)
      @bug.update(developer_ids: @bug.developer_ids)
    end

    def add_id
      if @bug.developer_ids.include?(current_user.id.to_s)
        flash[:error] = 'You Are Already Assigned this BUG'
        redirect_to authenticated_root_path and return
      else
        @bug.developer_ids.push(current_user.id)
        @bug.update(developer_ids: @bug.developer_ids)
      end
    end
  end
end
