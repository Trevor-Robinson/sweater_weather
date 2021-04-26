require 'rails_helper'
RSpec.describe BackgroundFacade do
  it 'can get an image' do
    VCR.use_cassette('background_facade') do
      coords = {:lat=>39.738453, :lng=>-104.984853}
      location = "denver,co"
      coord = Coordinates.new(coords)
      facade = BackgroundFacade.new
      result = facade.get_image(location, coord)
    end
  end
end
