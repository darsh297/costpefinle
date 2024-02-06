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

        # If the role is 2, set designation_id and department_id to nil
        if @user.role_id == 2
          @user.designation_id = nil
          @user.department_id = nil
        end

        if @user.save
          flash[:notice] = "#{@user.email} created successfully."
          redirect_to users_path
        else
          flash[:notice] = "User cannot be created."
          puts @user.errors.full_messages  # Add this line to print validation errors to console
          render :new
        end
      end

      def show
        @user = User.find(params[:id])

      end

      def edit
        @user = User.find(params[:id])
      end
      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to @user, notice: 'User profile was successfully updated.'
        else
          render :edit
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
      if action_name == 'create'
        params.require(:user).permit(:email, :password, :role_id, :company_id, :department_id, :designation_id)
      elsif action_name == 'update'
        params.require(:user).permit(:f_name, :l_name, :accountnumber, :ifsc, :mobileNumber, :joiningDate)
      end
    end
