class Daily
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon
  def initialize(data)
    @date = parse_time(data[:dt]).to_date
    @sunrise = parse_time(data[:sunrise])
    @sunset = parse_time(data[:sunset])
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def parse_time(time)
    DateTime.strptime(time.to_s,'%s')
  end
end
