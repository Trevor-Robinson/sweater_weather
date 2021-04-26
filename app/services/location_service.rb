class LocationService

  def get_coordinates(location)
    data = get_location_data(location)
    data[:results].first[:locations].first[:latLng]
 end

  private

  def get_location_data(location)
    response = connection.get("/geocoding/v1/address") do |req|
      req.params['key'] = ENV['location_key']
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

end
