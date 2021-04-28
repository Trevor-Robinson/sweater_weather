class WeatherService
  def get_weather(coordinates)
    weather_data = get_data(coordinates)
    if !weather_data[:cod].nil?
      {status: weather_data[:cod].to_i, error: weather_data[:message]}
    else
      {current_weather: weather_data[:current], daily_weather: weather_data[:daily][0..4], hourly_weather: weather_data[:hourly][0..7]}
    end
 end

 def get_forecast(coordinates)
   weather_data = get_data(coordinates)
   weather_data[:current]
 end

 def get_weather_at_eta(hours, coordinates)
   weather_data = get_data(coordinates)
   if !weather_data[:cod].nil?
     {status: weather_data[:cod].to_i, error: weather_data[:message]}
   elsif hours < 0 || hours > 200
     {status: 400, error: "Invalid hour count"}
   elsif hours == 0
     {temperature: weather_data[:current][:temp], conditions: weather_data[:current][:weather].first[:description]}
   elsif hours > 48
     days = (hours/24.to_f).ceil
     {temperature: weather_data[:daily][days][:temp][:day], conditions: weather_data[:daily][days][:weather].first[:description]}
   else
     {temperature: weather_data[:hourly][hours][:temp], conditions: weather_data[:hourly][hours][:weather].first[:description]}
   end
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
