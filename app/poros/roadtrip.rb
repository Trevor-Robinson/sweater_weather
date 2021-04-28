class Roadtrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :id
  def initialize(origin, destination, time, weather_at_eta = 0)
    @id = id
    @start_city = origin
    @end_city = destination
    @travel_time = time
    if weather_at_eta == 0
      @weather_at_eta = {}
    else
      @weather_at_eta = Eta.new(weather_at_eta)
    end
  end
end
