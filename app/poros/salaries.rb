class Salaries
  attr_reader :id,
              :forecast,
              :salaries
  def initialize(salaries, forecast)
    @id = id
    @forecast = create_forecast(forecast)
    @salaries = create_salaries(salaries)
  end

  def create_forecast(forecast)
    Forecast.new(forecast)
  end
  def create_salaries(salaries)
    salaries.map do |salary|
      Salary.new(salary)
    end
  end
end
