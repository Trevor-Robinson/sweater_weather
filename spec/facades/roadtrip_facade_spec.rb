require 'rails_helper'
RSpec.describe RoadtripFacade do
  describe 'Happy path' do
    it 'can get roadtrip object from origin and destination' do
      VCR.use_cassette('regular_trip') do
        origin = "Denver,CO"
        destination = "Pueblo,CO"
        facade = RoadtripFacade.new
        result = facade.get_roadtrip_details(origin, destination)
        expect(result).to be_a(Roadtrip)
        expect(result.start_city).to eq(origin)
        expect(result.end_city).to eq(destination)
        expect(result.travel_time).to eq("1 hour, 44 minutes")
        expect(result.weather_at_eta).to be_a(Eta)
        expect(result.weather_at_eta.conditions).to be_a(String)
        expect(result.weather_at_eta.temperature).to be_a(Float)
      end
    end
    it 'can get correct roadtrip object for long trip' do
      VCR.use_cassette('long_trip') do
        origin = "New York, NY"
        destination = "Los Angeles, CA"
        facade = RoadtripFacade.new
        result = facade.get_roadtrip_details(origin, destination)
        expect(result).to be_a(Roadtrip)
        expect(result.start_city).to eq(origin)
        expect(result.end_city).to eq(destination)
        expect(result.travel_time).to eq("40 hours, 34 minutes")
        expect(result.weather_at_eta).to be_a(Eta)
        expect(result.weather_at_eta.conditions).to be_a(String)
        expect(result.weather_at_eta.temperature).to be_a(Float)
      end
    end
    it 'can get correct roadtrip object for short trip' do
      VCR.use_cassette('short_trip') do
        origin = "Denver, CO"
        destination = "Boulder, CO"
        facade = RoadtripFacade.new
        result = facade.get_roadtrip_details(origin, destination)
        expect(result).to be_a(Roadtrip)
        expect(result.start_city).to eq(origin)
        expect(result.end_city).to eq(destination)
        expect(result.travel_time).to eq("35 minutes")
        expect(result.weather_at_eta).to be_a(Eta)
        expect(result.weather_at_eta.conditions).to be_a(String)
        expect(result.weather_at_eta.temperature).to be_a(Float)
      end
    end
    it 'can convert seconds to readable hour and minute time' do
      facade = RoadtripFacade.new
      result1 = facade.seconds_to_time(3000)
      result2 = facade.seconds_to_time(5000)
      result3 = facade.seconds_to_time(10000)
      expect(result1).to eq("50 minutes")
      expect(result2).to eq("1 hour, 23 minutes")
      expect(result3).to eq("2 hours, 46 minutes")
    end
  end
  describe 'Sad Path' do
    it 'returns impossible travel time if route is impossible' do
      origin = "Denver, CO"
      destination = "London, UK"
      facade = RoadtripFacade.new
      result = facade.get_roadtrip_details(origin, destination)
      expect(result).to be_a(Roadtrip)
      expect(result.start_city).to eq(origin)
      expect(result.end_city).to eq(destination)
      expect(result.travel_time).to eq("impossible route")
      expect(result.weather_at_eta).to be_a(Hash)
      expect(result.weather_at_eta.empty?).to eq(true)
    end
  end
end
