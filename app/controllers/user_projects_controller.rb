class UserProjectsController < ApplicationController

  def index

    @projects=User.find(params[:id]).projects
    @user=User.find(params[:id])

  end
  def unassigned

    project=UserProject.where('user_id = ?', params[:id]).pluck("project_id")
    @user=User.find(params[:id])
    # @userprojects=Project.left_outer_joins(:user_projects).where('project_id= ?', project)
    # puts @userprojects.ids
    @userprojects=Project.where.not(id: project)

    # @projects=Project.eager_load(:users).where('forms.kind = "health"')
  end

  def assign
    project=Project.find(params[:id])
    puts "Project Name is #{project.name}"
    user=User.find(params[:userid])
    puts "Hello #{project.id}"
    @userproject = UserProject.create(user_id: params[:userid], project_id: project.id,name: project.name)
    # user.projects << project
    redirect_to action: 'unassigned', id: user.id
  end

  def remove
    user=User.find(params[:userid])
    # project=UserProject.where('user_id = ?', params[:userid]).and(UserProject.where('project_id = ?', params[:id]))
    project=UserProject.where(:user_id => params[:userid], :project_id => params[:id])
    UserProject.destroy(project.ids)
    redirect_to action: 'index', id: user.id

  end

  def dev_view_projects
      @projects=UserProject.where(:user_id => params[:id])
      if (current_user.qa?)
        render 'qa_view_projects'
      else
        render 'dev_view_projects'
      end
  end

end
