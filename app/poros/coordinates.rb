class Coordinates
  attr_reader :lat,
              :lon

  def initialize(data)
    @lat = data[:lat]
    @lon = data[:lng]
  end
end
