class Api::V1::SalariesController < ApplicationController
  def show
    facade = SalariesFacade.new
    render json: SalariesSerializer.new(facade.get_data(params[:destination]))
  end
end
