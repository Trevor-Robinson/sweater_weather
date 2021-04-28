class Api::V1::BackgroundsController < ApplicationController
  def show
    background = BackgroundFacade.new
    data = background.background(params[:location])
    if data.class == Error
      render json: "Invalid location", status: 400
    else
      render json: BackgroundSerializer.new(data)
    end
  end
end
