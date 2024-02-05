class ClientsController < ApplicationController
  def index
    @client = Client.all
  end
end
