class ClientsController < ApplicationController
  def index
    @client = Client.all
  end

  def new
    @client =Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id

    if @client.save
      redirect_to new_client_path
    else
      render 'new'
    end
  end

  private

  def client_params

      params.require(:client).permit(:user_id, :client_name)
  end


end
