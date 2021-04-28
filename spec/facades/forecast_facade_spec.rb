require 'rails_helper'
RSpec.describe ForecastFacade do
  describe 'Happy Path' do
  it 'can return coordinates object' do
    VCR.use_cassette('get_coordinates') do
      facade = ForecastFacade.new
      results = facade.get_coordinates("denver,CO")

      expect(results).to be_a(Coordinates)
      expect(results.lat).to eq(39.738453)
      expect(results.lon).to eq(-104.984853)
    end
  end

  it 'can return a weather object' do
    VCR.use_cassette('get_forecast') do
      coords = Coordinates.new({:lat=>39.738453, :lng=>-104.984853})
      facade = ForecastFacade.new
      results = facade.get_weather(coords)
      expect(results).to be_a(Weather)
      expect(results.current_weather).to be_a(Current)
      expect(results.current_weather.class.instance_methods(false)).to match_array([:datetime, :visibility, :conditions, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :icon, :parse_time])
      expect(results.current_weather.methods).to_not include(:pressure, :hummidity, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)
      expect(results.current_weather.conditions).to be_a(String)
      expect(results.current_weather.icon).to be_a(String)
      expect(results.current_weather.datetime).to be_a(ActiveSupport::TimeWithZone)
      expect(results.current_weather.sunrise).to be_a(ActiveSupport::TimeWithZone)
      expect(results.current_weather.sunset).to be_a(ActiveSupport::TimeWithZone)
      expect(results.current_weather.feels_like).to be_a(Float)
      expect(results.current_weather.temperature).to be_a(Float)
      expect(results.current_weather.uvi).to be_a(Float)
      expect(results.current_weather.visibility).to be_a(Integer)
      expect(results.current_weather.humidity).to be_a(Integer)
      expect(results.daily_weather).to be_a(Array)
      results.daily_weather.each do |day|
        expect(day).to be_a(Daily)
        expect(day.class.instance_methods(false)).to match_array([:date, :conditions, :sunrise, :sunset, :min_temp, :max_temp, :icon, :parse_time])
        expect(day.conditions).to be_a(String)
        expect(day.icon).to be_a(String)
        expect(day.min_temp).to be_a(Float)
        expect(day.max_temp).to be_a(Float)
        expect(day.max_temp).to be_a(Float)
        expect(day.date).to be_a(Date)
        expect(day.sunrise).to be_a(DateTime)
        expect(day.sunset).to be_a(DateTime)
      end
      expect(results.hourly_weather).to be_a(Array)
      results.hourly_weather.each do |hour|
        expect(hour).to be_a(Hourly)
        expect(hour.class.instance_methods(false)).to match_array([:conditions, :icon, :temperature, :time, :parse_time])
        expect(hour.conditions).to be_a(String)
        expect(hour.icon).to be_a(String)
        expect(hour.time).to be_a(String)
        expect(hour.temperature).to be_a(Float)
      end
    end
  end
  it 'can send location and get back weather' do
    VCR.use_cassette('weather_data') do
      facade = ForecastFacade.new
      results = facade.weather_data("denver,CO")
      expect(results.class).to eq(Weather)
    end
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
