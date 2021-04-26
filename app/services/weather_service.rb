class WeatherService
  def get_forecast(coordinates)
    weather_data = get_data(coordinates)
    {current_weather: weather_data[:current], daily_weather: weather_data[:daily][0..4], hourly_weather: weather_data[:hourly][0..7]}
 end


  private

  def get_data(coordinates)
    response = connection.get("/data/2.5/onecall") do |req|
      req.params['lat'] = coordinates.lat
      req.params['lon'] = coordinates.lon
      req.params['exclude'] = 'minutely,alerts'
      req.params['units'] = 'imperial'
      req.params['APPID'] = ENV['weather_key']
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end
