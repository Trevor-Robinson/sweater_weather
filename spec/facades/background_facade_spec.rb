require 'rails_helper'
RSpec.describe BackgroundFacade do
  it 'can get an image' do
    VCR.use_cassette('get_image') do
      coords = {:lat=>39.738453, :lng=>-104.984853}
      location = "denver,co"
      coord = Coordinates.new(coords)
      facade = BackgroundFacade.new
      result = facade.get_image(location, coord)
      image_data = [:location, :image_url, :credit, :id]
      credit_data = [:author_profile, :notice, :author, :source]
      expect(result).to be_a(Image)
      expect(result.credit).to be_a(Credit)

      expect(result.class.instance_methods(false)).to match_array(image_data)
      expect(result.credit.class.instance_methods(false)).to match_array(credit_data)
      expect(result.id).to be_nil
      expect(result.location).to eq(location)
      expect(result.image_url).to be_a(String)
      expect(result.credit.author).to be_a(String)
      expect(result.credit.author_profile).to be_a(String)
      expect(result.credit.notice).to eq("This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.")
      expect(result.credit.source).to eq("flickr.com")
    end
  end
  it 'can create search tags' do
    location = "denver,co"
    facade = BackgroundFacade.new
    result = facade.create_tags(location)
    expect(result).to eq("denver skyline")
  end
  it 'can return coordinates object' do
    VCR.use_cassette('get_coordinates') do
      facade = BackgroundFacade.new
      results = facade.get_coordinates("denver,CO")
      expect(results).to be_a(Coordinates)
      expect(results.lat).to eq(39.738453)
      expect(results.lon).to eq(-104.984853)
    end
  end
  it 'can create url for image' do
    photo_data =  {:id=>"50948688121",
 :owner=>"91357526@N00",
 :secret=>"7511ec5d52",
 :server=>"65535",
 :farm=>66,
 :title=>"Denver at Early Evening (6.46pm Pano), 15 July 2020",
 :ispublic=>1,
 :isfriend=>0,
 :isfamily=>0}
    facade = BackgroundFacade.new
    result = facade.create_url(photo_data)
    expect(result).to eq( "https://live.staticflickr.com/65535/50948688121_7511ec5d52_b.jpg")
  end
  it 'can get image given a location' do
    VCR.use_cassette('background_facade') do
      location = "denver,co"
      facade = BackgroundFacade.new
      result = facade.background(location)
      expect(result).to be_a(Image)
      expect(result.credit).to be_a(Credit)
      image_data = [:location, :image_url, :credit, :id]
      credit_data = [:author_profile, :notice, :author, :source]

      expect(result.class.instance_methods(false)).to match_array(image_data)
      expect(result.credit.class.instance_methods(false)).to match_array(credit_data)
      expect(result.id).to be_nil
      expect(result.location).to eq(location)
      expect(result.image_url).to be_a(String)
      expect(result.credit.author).to be_a(String)
      expect(result.credit.author_profile).to be_a(String)
      expect(result.credit.notice).to eq("This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.")
      expect(result.credit.source).to eq("flickr.com")
    end
  end
  describe 'Sad Path' do
    it 'returns error if location is invalid' do
      VCR.use_cassette('bad_location') do
        facade = BackgroundFacade.new
        results = facade.background("")
        expect(results).to be_a(Error)
        expect(results.status).to eq(400)
        expect(results.error).to eq("Illegal argument from request: Insufficient info for location")
      end
    end
  end
end
