require 'rails_helper'

RSpec.describe 'Location Service' do
  describe 'happy path' do
    it 'returns data from the api' do
      VCR.use_cassette('location_api') do
        location = 'denver,CO'
        locationservice = LocationService.new
        res = locationservice.get_coordinates(location)
        expect(res[:lat]).to eq(39.738453)
        expect(res[:lng]).to eq(-104.984853)
      end
    end
  end
end
