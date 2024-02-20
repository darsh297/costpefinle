class CheckInsController < ApplicationController

  def index
    @check_ins = current_user.check_ins
    @check_in = current_user.check_ins.last || CheckIn.new
  end


  def new
    @check_in = CheckIn.new
    @check_ins = CheckIn.all
  end

def create
  if params[:commit] == "Check In"
    # Check if the user has already checked in today
    if current_user.check_ins.where('DATE(check_in_time) = ?', Date.today).exists?
      redirect_to check_ins_path, alert: "You have already checked in today."
      return
    end

    @check_in = current_user.check_ins.build(check_in_time: Time.now)
    if @check_in.save
       redirect_to check_ins_path, notice: "Check-in successful."
    else
      render :new
    end
  elsif params[:commit] == "Check Out"
    @check_in = current_user.check_ins.last
    if @check_in.update(check_out_time: Time.now)
       redirect_to check_ins_path, notice: "Check-out successful."
    else
      render :new
    end
  end
end

def checkout
  @check_in = current_user.check_ins.last

  # Check if the user has already checked out today
  if current_user.check_ins.where('DATE(check_out_time) = ?', Date.today).exists?
     redirect_to  check_ins_path, alert: "You have already checked out today."
    return
  end

  # Check if the user has checked in before allowing check out
  if @check_in.nil?

    render :new ,  alert: "You have already checked out today."
    return
  end

  if @check_in.update(check_out_time: Time.now)
     redirect_to check_ins_path, notice: "Check-out successful."
  else
    render :new
  end
end

  private

  def set_check_in
    @check_in = current_user.check_ins.find(params[:id])
  end
end
