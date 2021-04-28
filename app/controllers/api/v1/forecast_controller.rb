class Api::V1::ForecastController < ApplicationController
  def show
    forecast = ForecastFacade.new
    data = forecast.weather_data(params[:location])
    if data.class == Error
      render json: "Invalid location", status: 400
    else
      render json: ForecastSerializer.new(data)
    end
  end
end
