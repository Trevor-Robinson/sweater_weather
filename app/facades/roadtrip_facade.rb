class RoadtripFacade
  def get_roadtrip_details(origin, destination)
    locationservice = LocationService.new
    data = locationservice.get_travel_info(origin, destination)
    if data[:status] == 402
      Roadtrip.new(origin, destination, data[:error])
    else
      time = seconds_to_time(data[:time])
      weatherservice = WeatherService.new
      coords = Coordinates.new(data[:coords])
      weather_at_eta = weatherservice.get_weather_at_eta(@hours, coords)
      Roadtrip.new(origin, destination, time, weather_at_eta)
    end  
  end

  def seconds_to_time(seconds)
    minutes = (seconds / 60) % 60
    @hours = seconds / (60 * 60)
    if @hours == 0
      "#{minutes} minutes"
    elsif @hours == 1
      "#{@hours} hour, #{minutes} minutes"
    else
      "#{@hours} hours, #{minutes} minutes"
    end
  end

end
