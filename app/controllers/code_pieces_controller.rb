class CodePiecesController < ApplicationController
  def index
    @bugs=Bug.where(user_id: params[:id])
    puts @bugs.ids
  end
  def unassigned
    bug_titles=Bug.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    @bugs=Bug.where(:project_id => params[:id]).where.not(:title => bug_titles)

  end
  def assigned
    bug_titles=Bug.where(user_id: params[:userid],project_id: params[:id]).pluck(:title)
    @bugs=Bug.where(:project_id => params[:id],:title => bug_titles,user_id: params[:userid])

  end
  def assign

  end
end
