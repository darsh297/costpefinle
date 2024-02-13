class ClientsController < ApplicationController
def index
  if current_user.role_id == 2
    client_ids = current_user.clients.pluck(:id)
    @clients = Client.where(id: client_ids)
  else
    @clients = Client.all
  end
end

def show
  @client = Client.find(params[:id])
end

  def new
    @client =Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id

    if @client.save
      redirect_to clients_path
    else
      render 'new'
    end
  end

  def edit
        @client = Client.find(params[:id])
      end
      def update
        @client = Client.find(params[:id])
        if @client.update(client_params)
          redirect_to clients_path
        else
          render :edit
        end
      end



    def soft_delete
      @client = Client.find(params[:id])
      @client.soft_delete

      redirect_to clients_path, notice: 'User was successfully soft deleted.'
    end

  private

  def client_params

      params.require(:client).permit(:user_id, :client_name , :is_active , :company_id )
  end


end
