class WorkreportsController < ApplicationController
  def index
    @workreports = current_user.workreports
    @users = User.all  # Or however you are fetching the users
  end

  def show
    if current_user.role_id == 1
      @workreport = Workreport.all.order(date: :desc)       # @workreport = @workreport.joins(:user).where('users.f_name ILIKE ?', "%#{params[:user_first_name]}%")

    else
  users_in_same_company = User.where(company_id: current_user.company_id)
  @workreport = Workreport.where(user_id: users_in_same_company.pluck(:id))

    end
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

    # If params[:user_id] is present, set the user_id accordingly
  end

  def create
    @workreport = Workreport.new(workreport_params)
    @workreport.created_by = current_user.id



    if @workreport.save
       if params[:user_id].present?
        redirect_to workreports_path
       else
        redirect_to others_workreports_path
       end
    else
      render 'new'
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
