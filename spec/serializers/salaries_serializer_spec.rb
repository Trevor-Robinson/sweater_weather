require 'rails_helper'
RSpec.describe SalariesSerializer do
  it 'returns data in the correct format' do
    facade = SalariesFacade.new
    serialized = SalariesSerializer.new(facade.get_data("chicago")).serialized_json
    test = JSON.parse(serialized, symbolize_names: true)
    expect(test).to have_key(:data)
    expect(test[:data]).to be_a(Hash)
    expect(test[:data]).to have_key(:id)
    expect(test[:data][:id]).to be_nil
    expect(test[:data]).to have_key(:type)
    expect(test[:data][:type]).to eq("salaries")
    expect(test[:data]).to have_key(:attributes)
    expect(test[:data][:attributes]).to be_a(Hash)
    expect(test[:data][:attributes]).to have_key(:forecast)
    expect(test[:data][:attributes][:forecast]).to be_a(Hash)
    expect(test[:data][:attributes][:forecast]).to have_key(:summary)
    expect(test[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(test[:data][:attributes][:forecast][:summary]).to be_a(String)
    expect(test[:data][:attributes][:forecast][:temperature]).to be_a(String)
    expect(test[:data][:attributes]).to have_key(:salaries)
    expect(test[:data][:attributes][:salaries]).to be_a(Array)
    expect(test[:data][:attributes][:salaries].count).to be <= 7
    test[:data][:attributes][:salaries].each do |salary|
      expect(salary).to be_a(Hash)
      expect(salary).to have_key(:title)
      expect(salary[:title]).to be_a(String)
      expect(salary).to have_key(:min)
      expect(salary[:min]).to be_a(String)
      expect(salary).to have_key(:max)
      expect(salary[:max]).to be_a(String)
    end

  end
end
