class ForecastFacade
  def weather_data(location)
    coordinates = get_coordinates(location)
    get_forecast(coordinates)
  end

  def get_coordinates(location)
    service = LocationService.new
    coordinates = service.get_coordinates(location)
    Coordinates.new(coordinates)
  end

  def get_forecast(coordinates)
    service = WeatherService.new
    forecast = service.get_forecast(coordinates)
    Forecast.new(forecast)
  end
end
