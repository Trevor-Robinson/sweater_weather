class Eta
  attr_reader :conditions,
              :temperature
  def initialize(data)
    @conditions = data[:conditions]
    @temperature = data[:temperature]
  end

end
