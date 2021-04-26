class ForecastFacade
  def weather_data(location)
    coordinates = get_coordinates(location)
    get_weather(coordinates)
  end

  def get_coordinates(location)
    service = LocationService.new
    coordinates = service.get_coordinates(location)
    Coordinates.new(coordinates)
  end

  def get_weather(coordinates)
    service = WeatherService.new
    forecast = service.get_weather(coordinates)
    Weather.new(forecast)
  end
end
