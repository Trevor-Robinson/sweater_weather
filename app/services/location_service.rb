class LocationService

  def get_coordinates(location)
    data = get_location_data(location)
    if data[:info][:statuscode] >= 400
      {status: data[:info][:statuscode], error: data[:info][:messages].first}
    else
      data[:results].first[:locations].first[:latLng]
    end
 end

 def get_travel_info(origin, destination)
   data = get_route_info(origin, destination)
   if data[:info][:statuscode] >= 400
     {status: 402, error: 'impossible route'}
   else
     {time: data[:route][:time], coords: data[:route][:locations].last[:latLng]}
   end
 end

private

  def get_route_info(origin, destination)
    response = connection.get("/directions/v2/route") do |req|
      req.params['key'] = ENV['location_key']
      req.params['from'] = origin
      req.params['to'] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end

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
