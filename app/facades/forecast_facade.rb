class ForecastFacade
  def weather_data(location)
    coordinates = get_coordinates(location)
    if coordinates.class == Error
      coordinates
    else
      get_weather(coordinates)
    end  
  end

  def get_coordinates(location)
    service = LocationService.new
    coordinates = service.get_coordinates(location)
    if !coordinates[:status].nil?
      Error.new(coordinates)
    else
      Coordinates.new(coordinates)
    end
  end

  def get_weather(coordinates)
    service = WeatherService.new
    forecast = service.get_weather(coordinates)
    Weather.new(forecast)
  end
end
