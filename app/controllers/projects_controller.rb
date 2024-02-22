class ProjectsController < ApplicationController


  def index
  if current_user.role.role_name == "Root"
    @projects = Project.all
  else
    @projects = current_user.company.projects
  end

  end



  def show
        @project = Project.find(params[:id])
  end

  def new
    @project = Project.new

  end
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.company_id = current_user.company_id

    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def edit
      @project = Project.find(params[:id])
  end


      def update
        @project = Project.find(params[:id])
        if @project.update(project_params)
          redirect_to projects_path
        else
          render :edit
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
