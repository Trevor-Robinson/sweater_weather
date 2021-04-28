require 'rails_helper'
RSpec.describe Current do
  before :each do
    data = {:dt=>1619381136,
            :sunrise=>1619352457,
            :sunset=>1619401664,
            :temp=>75.49,
            :feels_like=>73.72,
            :pressure=>1003,
            :humidity=>21,
            :dew_point=>32.86,
            :uvi=>7.43,
            :clouds=>10,
            :visibility=>10000,
            :wind_speed=>1.01,
            :wind_deg=>302,
            :wind_gust=>5.01,
            :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}]}

    @result = Current.new(data)
  end
  it 'makes Current object from data and excludes unneeded data' do
    expect(@result).to be_a(Current)
    expect(@result.methods).to include(:datetime, :visibility, :conditions, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :icon)
    expect(@result.methods).to_not include(:pressure, :hummidity, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)
  end

  it 'parses unix time into local DateTime' do
    expect(@result.datetime).to eq("Sun, 25 Apr 2021 14:05:36 MDT -06:00")
  end
end
