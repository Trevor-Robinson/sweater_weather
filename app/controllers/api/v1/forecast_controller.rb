class Api::V1::ForecastController < ApplicationController
  def show
    forecast = ForecastFacade.new
    render json: ForecastSerializer.new(forecast.weather_data(params[:location]))
  end
end
