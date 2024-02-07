class ProjectsController < ApplicationController


  def index
  if current_user.role_id == 1
    @projects = Project.all
  else
    @projects = current_user.company.projects
  end

  end
  def show
    @project =current_user.projects
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def soft_delete
    @project = Project.find(params[:id])
    @project.soft_delete

    redirect_to projects_path
  end

  private




  def project_params
    params.require(:project).permit(:client_id, :name , :user_id)
  end
end
