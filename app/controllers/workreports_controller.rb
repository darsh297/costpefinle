class WorkreportsController < ApplicationController
  load_and_authorize_resource
 def index
  @workreports = current_user.workreports.order(date: :desc)
  @users = User.all
end


def allworkreports
  if current_user.role_id == 6
    redirect_to root_path, alert: "Access denied"
  elsif current_user.role_id == 1
    @workreports = Workreport.order(date: :desc).all
  elsif current_user.role_id == 2
    user_ids_in_same_company = User.where(company_id: current_user.company_id).pluck(:id)
    @workreports = Workreport.where(user_id: user_ids_in_same_company).order(date: :desc)
  else
    current_user_id = current_user.id
    email_hierarchies = EmailHierarchy.where("to_ids LIKE ? OR cc_ids LIKE ?", "%#{current_user_id}%", "%#{current_user_id}%")
    user_workreport_ids = email_hierarchies.pluck(:user_id).uniq
    @workreports = Workreport.where(user_id: user_workreport_ids).order(date: :desc)
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

   a = EmailHierarchy.where(user_id: params[:user_id])
   @to = a.pluck(:to_ids).map { |ids| ids.split(',') }.flatten
   @cc = a.pluck(:cc_ids).map { |ids| ids.split(',') }.flatten
   @@to_emails = User.where(id: @to).pluck(:email)
   @@cc_emails = User.where(id: @cc).pluck(:email)
 elsif current_user.role_id == 6
          redirect_to workreports_path,notice: "You are not authorized person to access this page"
 else
   set_default_date
 end
end


def create
    @workreport = Workreport.new(workreport_params)
    @workreport.created_by = current_user.id

    if @workreport.save
      # binding.pry
      WorkreportMailer.with(workreport: @workreport, to_emails: @@to_emails, cc_emails: @@cc_emails).created.deliver_now

      if @workreport.user_id == current_user.id
        redirect_to workreports_path
      else
        redirect_to allworkreports_path

      end
    else
      render 'new'
    end
  end

  def edit
    if Time.now.hour >= 12 || @workreport.date < Date.today - 1
      redirect_to @workreport, alert: "You cannot edit this work report after 12 PM or after the next day."
    end
  end

  def update
    if Time.now.hour >= 12 || @workreport.date < Date.today - 1
      redirect_to @workreport, alert: "You cannot edit this work report after 12 PM or after the next day."
    else
      if @workreport.update(workreport_params)
        redirect_to @workreport, notice: 'Work report was successfully updated.'
      else
        render :edit
      end
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
