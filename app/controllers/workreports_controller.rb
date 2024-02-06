class WorkreportsController < ApplicationController
  def index
      @workreport = current_user.workreport
  end
  def show
    @workreport = Workreport.all
  end

  def new
    @workreport = Workreport.new
    set_default_date if current_user.role_id != 6
  end

  def create
    @workreport = Workreport.new(workreport_params)
    @workreport.user_id = current_user.id
    @workreport.date = Date.current if current_user.role_id != 6

    if @workreport.save
      redirect_to workreports_path
    else
      set_default_date if current_user.role_id != 6
      render 'new'
    end
  end


  private

  def workreport_params
    params.require(:workreport).permit(:date, :project_id , :tasks , :hours , :minutes ,  :status )
  end

  def set_default_date
    @workreport.date = Date.current
  end
end
