require 'rails_helper'
RSpec.describe Forecast do
  it 'returns Salary as a poro with only needed data' do
    data = {:job=>{:id=>"DATA-ANALYST", :title=>"Data Analyst"},
 :salary_percentiles=>{:percentile_25=>46898.18614517015, :percentile_50=>56442.498784333024, :percentile_75=>67929.18726447425}}

 expected_methods = [:title, :min, :max, :to_money]

 result = Salary.new(data)
 expect(result).to be_a(Salary)
 expect(result.class.instance_methods(false)).to match_array(expected_methods)
  end
end
