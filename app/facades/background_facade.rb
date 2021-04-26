class BackgroundFacade
  def background(location)
    coordinates = get_coordinates(location)
    get_image(location, coordinates)
  end

  def get_coordinates(location)
    service = LocationService.new
    coordinates = service.get_coordinates(location)
    Coordinates.new(coordinates)
  end

  def get_image(location, coordinates)
    tags = create_tags(location)
    service = ImageService.new
    image_data = service.get_background(tags, coordinates)
    user = service.get_user(image_data[:photos][:photo].first[:owner])
    Image.new(image_data[:photos][:photo].first, location, user)
  end

  def create_tags(location)
    location.split(',').first + " skyline"
  end
end
