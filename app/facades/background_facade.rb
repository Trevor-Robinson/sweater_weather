class BackgroundFacade
  def background(location)
    coordinates = get_coordinates(location)
    if coordinates.class == Error
      coordinates
    else
      get_image(location, coordinates)
    end
  end

  def get_coordinates(location)
    service = LocationService.new
    coordinates = service.get_coordinates(location)
    if !coordinates[:status].nil?
      Error.new(coordinates)
    else
      Coordinates.new(coordinates)
    end
  end

  def get_image(location, coordinates)
    tags = create_tags(location)
    service = ImageService.new
    image_data = service.get_background(tags, coordinates)
    url = create_url(image_data[:photo])
    Image.new(image_data, url, location)
  end

  def create_tags(location)
    location.split(',').first + " skyline"
  end

  def create_url(image_data)
    "https://live.staticflickr.com/#{image_data[:server]}/#{image_data[:id]}_#{image_data[:secret]}_b.jpg"
  end
end
