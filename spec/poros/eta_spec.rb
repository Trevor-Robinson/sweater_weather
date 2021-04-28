require 'rails_helper'
RSpec.describe Eta do
  it 'makes Eta object from data' do
    data = {:temperature=>59.68, :conditions=>"clear sky"}
    result = Eta.new(data)
    expect(result).to be_a(Eta)
    expect(result.temperature).to eq(59.68)
    expect(result.conditions).to eq("clear sky")
  end
end
