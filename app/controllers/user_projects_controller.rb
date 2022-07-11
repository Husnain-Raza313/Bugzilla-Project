class UserProjectsController < ApplicationController

  def index

    @projects=User.find(params[:id]).projects

  end
  def unassigned

    project=UserProject.where('user_id = ?', params[:id]).pluck("project_id")

    # @userprojects=Project.left_outer_joins(:user_projects).where('project_id= ?', project)
    # puts @userprojects.ids
    @userprojects=Project.where.not(id: project)

    # @projects=Project.eager_load(:users).where('forms.kind = "health"')
  end

end
