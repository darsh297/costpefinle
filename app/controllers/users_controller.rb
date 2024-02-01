class UsersController < ApplicationController
      def index
        if current_user.role_id == 2
          @users = User.where(company_id: current_user.company_id, isactive: true, role_id: [2, 3, 4, 5,6])
        else
          @users = User.where(isactive: true)
        end
      end

      def new
        @user = User.new
      end

      def add_user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          flash[:notice] = "#{@user.email}! created successfully."
          redirect_to users_path
        else
          flash[:notice] = "User can not be created."
          render new 
        end
      end



    def soft_delete
      @user = User.find(params[:id])
      @user.soft_delete

      redirect_to users_path, notice: 'User was successfully soft deleted.'
    end

    end


    private


    def user_params
     params.require(:user).permit(:email, :password, :role_id, :company_id, :department_id, :designation_id)
    end
