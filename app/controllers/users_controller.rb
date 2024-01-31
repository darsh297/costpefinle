class UsersController < ApplicationController
      def index
        @user = User.all
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
          redirect_to users_path
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
