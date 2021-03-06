require 'rails_helper'

RSpec.describe 'Weather Service' do
  describe 'happy path' do
    it 'returns data from the api' do
      VCR.use_cassette('weather_api') do
        coords = Coordinates.new({:lat=>39.738453, :lng=>-104.984853})
        service = WeatherService.new
        response = service.get_weather(coords)
        expect(response).to_not have_key(:minutely_weather)
        expect(response).to_not have_key(:alerts)
        expect(response.count).to eq(3)
        expect(response).to have_key(:current_weather)
        expect(response[:current_weather]).to have_key(:dt)
        expect(response[:current_weather]).to have_key(:sunrise)
        expect(response[:current_weather]).to have_key(:sunset)
        expect(response[:current_weather]).to have_key(:temp)
        expect(response[:current_weather]).to have_key(:feels_like)
        expect(response[:current_weather]).to have_key(:humidity)
        expect(response[:current_weather]).to have_key(:uvi)
        expect(response[:current_weather]).to have_key(:visibility)
        expect(response[:current_weather]).to have_key(:weather)
        expect(response[:current_weather][:weather].first).to have_key(:description)
        expect(response[:current_weather][:weather].first).to have_key(:icon)
        expect(response[:current_weather][:dt]).to be_a(Integer)
        expect(response[:current_weather][:sunrise]).to be_a(Integer)
        expect(response[:current_weather][:sunset]).to be_a(Integer)
        expect(response[:current_weather][:temp]).to be_a(Float)
        expect(response[:current_weather][:feels_like]).to be_a(Float)
        expect(response[:current_weather][:humidity]).to be_a(Numeric)
        expect(response[:current_weather][:uvi]).to be_a(Numeric)
        expect(response[:current_weather][:visibility]).to be_a(Numeric)
        expect(response[:current_weather][:weather].first).to be_a(Hash)
        expect(response[:current_weather][:weather].first[:description]).to be_a(String)
        expect(response[:current_weather][:weather].first[:icon]).to be_a(String)
        expect(response).to have_key(:daily_weather)
        expect(response[:daily_weather].count).to eq(5)
        response[:daily_weather].each do |day|
          expect(day).to have_key(:dt)
          expect(day).to have_key(:sunrise)
          expect(day).to have_key(:sunset)
          expect(day).to have_key(:temp)
          expect(day[:temp]).to have_key(:min)
          expect(day[:temp]).to have_key(:max)
          expect(day).to have_key(:weather)
          expect(day[:weather].first).to have_key(:description)
          expect(day[:weather].first).to have_key(:icon)
          expect(day[:dt]).to be_a(Integer)
          expect(day[:sunrise]).to be_a(Integer)
          expect(day[:sunset]).to be_a(Integer)
          expect(day[:temp]).to be_a(Hash)
          expect(day[:temp][:min]).to be_a(Float)
          expect(day[:temp][:max]).to be_a(Float)
          expect(day[:weather].first).to be_a(Hash)
          expect(day[:weather].first[:description]).to be_a(String)
          expect(day[:weather].first[:icon]).to be_a(String)
        end
        expect(response).to have_key(:hourly_weather)
        expect(response[:hourly_weather].count).to eq(8)
        response[:hourly_weather].each do |hour|
          expect(hour).to have_key(:dt)
          expect(hour).to have_key(:temp)
          expect(hour).to have_key(:weather)
          expect(hour[:weather].first).to have_key(:description)
          expect(hour[:weather].first).to have_key(:icon)
          expect(hour[:dt]).to be_a(Integer)
          expect(hour[:temp]).to be_a(Float)
          expect(hour[:weather].first).to be_a(Hash)
          expect(hour[:weather].first[:description]).to be_a(String)
          expect(hour[:weather].first[:icon]).to be_a(String)
        end
      end
    end
    it 'returns weather at arrival time' do
      VCR.use_cassette('eta') do
        coords = Coordinates.new({:lat=>39.738453, :lng=>-104.984853})
        hours1 = 0
        hours2 = 24
        hours3 = 80
        service = WeatherService.new
        result1 = service.get_weather_at_eta(hours1, coords)
        result2 = service.get_weather_at_eta(hours2, coords)
        result3 = service.get_weather_at_eta(hours3, coords)
        expect(result1).to be_a(Hash)
        expect(result1.count).to eq(2)
        expect(result1[:temperature]).to be_a(Float)
        expect(result1[:conditions]).to be_a(String)
        expect(result2).to be_a(Hash)
        expect(result2.count).to eq(2)
        expect(result2[:temperature]).to be_a(Float)
        expect(result2[:conditions]).to be_a(String)
        expect(result3).to be_a(Hash)
        expect(result3.count).to eq(2)
        expect(result3[:temperature]).to be_a(Float)
        expect(result3[:conditions]).to be_a(String)
        expect(result1[:temperature]).to_not eq(result2[:temperature])
        expect(result1[:temperature]).to_not eq(result3[:temperature])
        expect(result2[:temperature]).to_not eq(result3[:temperature])
      end
    end
  end
  describe 'sad path' do
    it 'returns error if coordinates are invalid' do
      VCR.use_cassette('invalid_coords') do
      coords = Coordinates.new({:lat=>"blue", :lng=>10.984853})
      service = WeatherService.new
      response = service.get_weather(coords)
      expect(response).to be_a(Hash)
      expect(response.count).to eq(2)
      expect(response[:error]).to eq("wrong latitude")
      expect(response[:status]).to eq(400)
      end
    end
    it 'returns error if hours are invalid' do
      VCR.use_cassette('invalid_hours') do
      coords = Coordinates.new({:lat=>39.738453, :lng=>-104.984853})
      hours = -10
      service = WeatherService.new
      response = service.get_weather_at_eta(hours, coords)
      expect(response).to be_a(Hash)
      expect(response.count).to eq(2)
      expect(response[:error]).to eq("Invalid hour count")
      expect(response[:status]).to eq(400)
    end
    end
  end
end
