require 'rails_helper'
RSpec.describe Roadtrip do
  it 'makes Roadtrip object from data' do
    origin = "Denver,CO"
    destination = "Pueblo,CO"
    time = "1 hour, 44 minutes"
    weather = {:temperature=>59.68, :conditions=>"clear sky"}
    result = Roadtrip.new(origin, destination, time, weather)
    expect(result).to be_a(Roadtrip)
    expect(result.start_city).to eq(origin)
    expect(result.end_city).to eq(destination)
    expect(result.travel_time).to eq("1 hour, 44 minutes")
    expect(result.weather_at_eta).to be_a(Eta)
    expect(result.weather_at_eta.conditions).to eq('clear sky')
    expect(result.weather_at_eta.temperature).to eq(59.68)
  end
  it 'makes object with empty weather if no weather given' do
    origin = "Denver,CO"
    destination = "London,UK"
    time = "impossible route"
    result = Roadtrip.new(origin, destination, time)
    expect(result).to be_a(Roadtrip)
    expect(result.start_city).to eq(origin)
    expect(result.end_city).to eq(destination)
    expect(result.travel_time).to eq("impossible route")
    expect(result.weather_at_eta).to be_a(Hash)
    expect(result.weather_at_eta.empty?).to eq(true)
  end
end
