class WorkreportsController < ApplicationController
  load_and_authorize_resource
  def index
    @workreports = current_user.workreports
    @users = User.all  # Or however you are fetching the users
  end
def allworkreports
  if current_user.role_id == 1
    @workreports =Workreport.all
  else
  user_ids_in_same_company = User.where(company_id: current_user.company_id).pluck(:id)
  @workreports = Workreport.where(user_id: user_ids_in_same_company)
end
end

def show
   @workreports = Workreport.find(params[:id])
end

  def other
     @workreport = Workreport.new
     @users = User.all


  end


  def new
    @workreport = Workreport.new
    @users = User.all

 if params[:user_id].present?
   @workreport.user_id = params[:user_id]
   @workreport.date = Date.current
 else
   set_default_date
 end
end

  def create
    @workreport = Workreport.new(workreport_params)
    @workreport.created_by = current_user.id



      if @workreport.save
        if @workreport.user_id == current_user
        redirect_to workreports_path
       else
        redirect_to allworkreports_path
       end
    else
      render 'new'
    end
  end


  def edit
    @workreport = Workreport.find(params[:id])
    if Time.now.hour < 12 && @workreport.date >= Date.today - 1
  end
end

  def update
    @workreport = Workreport.find(params[:id])
    if @workreport.update(workreport_params)
      redirect_to @workreport, notice: 'workreport was successfully updated.'
    else
      render :edit
    end


  end


  private

  def workreport_params
    params.require(:workreport).permit(:user_id, :created_by, :date, :project_id, :tasks, :hours, :minutes, :status)
  end

  def set_default_date
    @workreport.date = Date.current
  end
end
