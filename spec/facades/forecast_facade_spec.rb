require 'rails_helper'
RSpec.describe ForecastFacade do
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
      expect(results.current_weather.methods).to include(:datetime, :visibility, :conditions, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :icon)
      expect(results.current_weather.methods).to_not include(:pressure, :hummidity, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)

      expect(results.daily_weather).to be_a(Array)
      results.daily_weather.each do |day|
        expect(day).to be_a(Daily)
        expect(day.methods).to include(:date, :conditions, :sunrise, :sunset, :min_temp, :max_temp, :icon)
      end
      expect(results.hourly_weather).to be_a(Array)
      results.hourly_weather.each do |hour|
        expect(hour).to be_a(Hourly)
        expect(hour.methods).to include(:conditions, :icon, :temperature, :time)
      end
    end
  end
  it 'can send location and get back forecast' do
    VCR.use_cassette('weather_data') do
      facade = ForecastFacade.new
      results = facade.weather_data("denver,CO")
      expect(results.class).to eq(Weather)
    end
  end
end
