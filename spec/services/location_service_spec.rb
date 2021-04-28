require 'rails_helper'

RSpec.describe 'Location Service' do
  describe 'happy path' do
    it 'returns coordinate data from the api' do
      VCR.use_cassette('location_api') do
        location = 'denver,CO'
        locationservice = LocationService.new
        res = locationservice.get_coordinates(location)
        expect(res[:lat]).to eq(39.738453)
        expect(res[:lng]).to eq(-104.984853)
      end
    end
    it 'returns travel info from the api' do
      VCR.use_cassette('Travel_info') do
        origin = "Chicago,IL"
        destination = "Las Vegas,NV"
        locationservice = LocationService.new
        res = locationservice.get_travel_info(origin, destination)
        expect(res).to be_a(Hash)
        expect(res.count).to eq(2)
        expect(res).to have_key(:time)
        expect(res[:time]).to be_a(Integer)
        expect(res).to have_key(:coords)
        expect(res[:coords]).to be_a(Hash)
        expect(res[:coords]).to have_key(:lng)
        expect(res[:coords]).to have_key(:lat)
        expect(res[:coords][:lng]).to be_a(Float)
        expect(res[:coords][:lat]).to be_a(Float)
      end
    end
  end
  describe 'Sad Path' do
    it 'returns error when no location is sent to get coordinates' do
      VCR.use_cassette('get_coords_error') do
        location = ''
        locationservice = LocationService.new
        res = locationservice.get_coordinates(location)
        expect(res).to be_a(Hash)
        expect(res.count).to eq(2)
        expect(res).to have_key(:status)
        expect(res[:status]).to eq(400)
        expect(res).to have_key(:error)
        expect(res[:error]).to be_a(String)
      end
    end
    it 'returns error when no route is found' do
      VCR.use_cassette('no_valid_route') do
        origin = "Chicago,IL"
        destination = "London,UK"
        locationservice = LocationService.new
        res = locationservice.get_travel_info(origin, destination)
        expect(res).to be_a(Hash)
        expect(res.count).to eq(2)
        expect(res).to have_key(:status)
        expect(res[:status]).to eq(402)
        expect(res).to have_key(:error)
        expect(res[:error]).to be_a(String)
      end
    end
    it 'returns error when missing info for route' do
      VCR.use_cassette('missing_info_route') do
        origin = "Chicago,IL"
        destination = ""
        locationservice = LocationService.new
        res = locationservice.get_travel_info(origin, destination)
        expect(res).to be_a(Hash)
        expect(res.count).to eq(2)
        expect(res).to have_key(:status)
        expect(res[:status]).to eq(402)
        expect(res).to have_key(:error)
        expect(res[:error]).to be_a(String)
      end
    end
  end
end
