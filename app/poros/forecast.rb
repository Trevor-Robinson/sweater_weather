class Forecast
  attr_reader :summary,
              :temperature
  def initialize(data)
    @summary = data[:weather].first[:description]
    @temperature = data[:temp].to_s.split('.').first + ' F'
  end

end
