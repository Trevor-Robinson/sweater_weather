require 'rails_helper'
RSpec.describe Daily do
  before :each do
    data = {:dt=>1619380800,
      :temp=>75.49,
      :feels_like=>73.72,
      :pressure=>1003,
      :humidity=>21,
      :dew_point=>32.86,
      :uvi=>7.43,
      :clouds=>10,
      :visibility=>10000,
      :wind_speed=>5.75,
      :wind_deg=>39,
      :wind_gust=>11.74,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
      :pop=>0}
      @result = Hourly.new(data)
  end

  it 'makes Hourly object from data and excludes unneeded data' do

    expect(@result.class).to eq(Hourly)
    expect(@result.methods).to include(:time, :conditions, :temperature, :icon)
    expect(@result.methods).to_not include(:feels_like, :pressure, :humidity, :dew_point, :wind_deg, :wind_gust, :clouds, :pop, :uvi)
  end

  it 'converts unix datetime to time' do
    expect(@result.time).to eq("14:00:00")
  end
end
