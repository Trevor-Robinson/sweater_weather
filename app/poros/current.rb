class Current
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon
  def initialize(data)
    @datetime = parse_time(data[:dt])
    @sunrise = parse_time(data[:sunrise])
    @sunset = parse_time(data[:sunset])
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def parse_time(time)
    DateTime.strptime(time.to_s,'%s').in_time_zone
  end
end
