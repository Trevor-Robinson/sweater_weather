require 'rails_helper'
RSpec.describe Forecast do
  it 'returns forecast as a poro with only needed data' do
    data = {:dt=>1619457963,
 :sunrise=>1619434384,
 :sunset=>1619484191,
 :temp=>67.8,
 :feels_like=>65.88,
 :pressure=>1014,
 :humidity=>34,
 :dew_point=>38.44,
 :uvi=>5.36,
 :clouds=>75,
 :visibility=>10000,
 :wind_speed=>16.11,
 :wind_deg=>170,
 :wind_gust=>27.63,
 :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04d"}]}
 expected_methods = [:summary, :temperature]

 result = Forecast.new(data)
 expect(result).to be_a(Forecast)
 expect(result.class.instance_methods(false)).to match_array(expected_methods)
  end
end
