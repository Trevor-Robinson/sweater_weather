class ImageService

  def get_background(search_query, coordinates)
    data = get_image_data(search_query, coordinates)
    if data[:photos][:photo].empty?
      {status: 400, error: "Invalid photo search"}
    else
      user = get_user(data[:photos][:photo].first[:owner])
      {photo: data[:photos][:photo].first, user: user[:user]}
    end
  end


  private
  def get_user(id)
    response = connection.get("/services/rest/") do |req|
      req.params['api_key'] = ENV['image_key']
      req.params['method'] = 'flickr.urls.getUserProfile'
      req.params['user_id'] = id
      req.params['format'] = "json"
      req.params['nojsoncallback'] = 1
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_image_data(search_query, coordinates)
    response = connection.get("/services/rest/") do |req|
      req.params['api_key'] = ENV['image_key']
      req.params['method'] = 'flickr.photos.search'
      req.params['tags'] = search_query
      req.params['license'] = 0
      req.params['geo_context'] = 2
      req.params['lat'] = coordinates.lat
      req.params['lon'] = coordinates.lon
      req.params['radius'] = 10
      req.params['radius_units'] = 10
      req.params['per_page'] = 1
      req.params['format'] = 'json'
      req.params['nojsoncallback'] = 1
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    Faraday.new(url: 'https://www.flickr.com')
  end

end
