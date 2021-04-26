class SalariesFacade

  def get_coordinates(location)
    service = LocationService.new
    coordinates = service.get_coordinates(location)
    Coordinates.new(coordinates)
  end

  def get_forecast(coordinates)
    service = WeatherService.new
    service.get_forecast(coordinates)
  end

  def get_salaries(location)
    service = SalariesService.new
    data = service.get_salaries(location)
    find_jobs(data)

  end

  def get_data(location)
    coordinates = get_coordinates(location)
    forecast = get_forecast(coordinates)
    salaries = get_salaries(location)
    Salaries.new(salaries, forecast)
  end

  def find_jobs(data)
    job_titles = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]
    jobs = []
    data.each do |job|
      if job_titles.include?(job[:job][:title])
        jobs << job
      end
    end
    jobs
  end


end
