require 'rails_helper'
RSpec.describe Daily do
  before :each do
    data = {:dt=>1619373600,
      :sunrise=>1619352457,
      :sunset=>1619401664,
      :moonrise=>1619396220,
      :moonset=>1619350440,
      :moon_phase=>0.44,
      :temp=>{:day=>73.06, :min=>47.25, :max=>75.63, :night=>63.09, :eve=>74.84, :morn=>47.25},
      :feels_like=>{:day=>70.95, :night=>46.13, :eve=>72.68,     :morn=>46.13},
      :pressure=>1002,
      :humidity=>19,
      :dew_point=>28.81,
      :wind_speed=>13.98,
      :wind_deg=>203,
      :wind_gust=>19.82,
      :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02d"}],
      :clouds=>17,
      :pop=>0.07,
      :uvi=>7.98}
    @result = Daily.new(data)
  end
  it 'makes Daily object from data and excludes unneeded data' do

    expect(@result.class).to eq(Daily)
    expect(@result.methods).to include(:date, :conditions, :sunrise, :sunset, :min_temp, :max_temp, :icon)
    expect(@result.methods).to_not include(:moonrise, :moonset, :moon_phase, :temp, :pressure, :humidity, :dew_point, :wind_deg, :wind_gust, :clouds, :pop, :uvi)
  end
  it 'converts unix time into appropriate day' do
    expect(@result.date).to eq("Sun, 25 Apr 2021".to_date)
  end

end
