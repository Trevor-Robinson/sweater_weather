class Weather
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id
  def initialize(data)
    @id = id
    @current_weather = Current.new(data[:current_weather])
    @daily_weather = daily(data[:daily_weather])
    @hourly_weather = hourly(data[:hourly_weather])
  end

  def daily(data)
    data.map do |day|
      Daily.new(day)
    end
  end

  def hourly(data)
    data.map do |hour|
      Hourly.new(hour)
    end
  end
end
