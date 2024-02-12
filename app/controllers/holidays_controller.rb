class HolidaysController < ApplicationController

  def index
    if current_user.role_id == 1
      @holidays = Holiday.all
    else
      creator_ids = User.where(company_id: current_user.company_id).pluck(:id)
      @holidays = Holiday.where(created_by: creator_ids)
    end
  end


  def show
    @holiday = Holiday.find(params[:id])
  end

  def new

    @holiday=Holiday.new
    @holiday.created_by = current_user.id if current_user.role_id == 1

  end

  def create
    @holiday = Holiday.new(holiday_params)
    @holiday.created_by = current_user.id
    if @holiday.save
      redirect_to holidays_path
    else
      render 'new'
    end
  end

  private

  def holiday_params
    params.require(:holiday).permit(:name , :holiday_date , :created_by)
  end


end
