class Hourly
  attr_reader :time,
              :temperature,
              :conditions,
              :icon
  def initialize(data)
    @time = parse_time(data[:dt])
    @temperature = data[:temp]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def parse_time(time)
    DateTime.strptime(time.to_s, '%s').in_time_zone.strftime('%T')
  end
end
