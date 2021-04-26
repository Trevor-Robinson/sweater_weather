require 'rails_helper'
RSpec.describe SalariesFacade do
  it 'can return coordinates object' do
      facade = SalariesFacade.new
      results = facade.get_coordinates("denver,CO")

      expect(results).to be_a(Coordinates)
      expect(results.lat).to eq(39.738453)
      expect(results.lon).to eq(-104.984853)
  end
  it "can find desired jobs" do
    data = [{:job=>{:id=>"COPYWRITER", :title=>"Copywriter"},
  :salary_percentiles=>{:percentile_25=>37874.33329144154, :percentile_50=>46571.95367417419, :percentile_75=>57266.9319969137}},
 {:job=>{:id=>"CUSTOMER-SUPPORT", :title=>"Customer Support"},
  :salary_percentiles=>{:percentile_25=>28709.782495494794, :percentile_50=>36911.39045392457, :percentile_75=>47455.97586661874}},
 {:job=>{:id=>"DATA-ANALYST", :title=>"Data Analyst"},
  :salary_percentiles=>{:percentile_25=>46898.18614517015, :percentile_50=>56442.498784333024, :percentile_75=>67929.18726447425}},
 {:job=>{:id=>"DATA-SCIENTIST", :title=>"Data Scientist"},
  :salary_percentiles=>{:percentile_25=>71025.60310363481, :percentile_50=>85799.94207526707, :percentile_75=>103647.55438088557}},
 {:job=>{:id=>"DENTIST", :title=>"Dentist"},
  :salary_percentiles=>{:percentile_25=>96511.24909217832, :percentile_50=>125690.57152330533, :percentile_75=>163692.00397319777}}]

 facade = SalariesFacade.new
 results = facade.find_jobs(data)
 expect(results).to eq([{:job=>{:id=>"DATA-ANALYST", :title=>"Data Analyst"},
  :salary_percentiles=>{:percentile_25=>46898.18614517015, :percentile_50=>56442.498784333024, :percentile_75=>67929.18726447425}},
 {:job=>{:id=>"DATA-SCIENTIST", :title=>"Data Scientist"},
  :salary_percentiles=>{:percentile_25=>71025.60310363481, :percentile_50=>85799.94207526707, :percentile_75=>103647.55438088557}}])
  end
end
