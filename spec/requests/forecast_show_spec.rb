require 'rails_helper'
RSpec.describe 'When I send a get request to api/v1/forecast' do
  describe 'Happy path' do
  it 'returns a forecast info' do
    VCR.use_cassette('forecast_request') do
    headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
    get '/api/v1/forecast?location=denver,co', headers: headers
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(response).to have_http_status(:success)
    expect(parsed).to be_a(Hash)
    expect(parsed[:data]).to be_a(Hash)
    expect(parsed[:data]).to have_key(:id)
    expect(parsed[:data][:id]).to be_nil
    expect(parsed[:data]).to have_key(:type)
    expect(parsed[:data][:type]).to eq("forecast")
    expect(parsed[:data]).to have_key(:attributes)
    expect(parsed[:data][:attributes]).to be_a(Hash)
    expect(parsed[:data][:attributes]).to have_key(:current_weather)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:datetime)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:sunrise)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:sunset)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:conditions)
    expect(parsed[:data][:attributes][:current_weather]).to have_key(:icon)
    expect(parsed[:data][:attributes][:current_weather][:datetime]).to be_a(String)
    expect(parsed[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
    expect(parsed[:data][:attributes][:current_weather][:sunset]).to be_a(String)
    expect(parsed[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
    expect(parsed[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
    expect(parsed[:data][:attributes][:current_weather][:humidity]).to be_a(Numeric)
    expect(parsed[:data][:attributes][:current_weather][:uvi]).to be_a(Numeric)
    expect(parsed[:data][:attributes][:current_weather][:visibility]).to be_a(Numeric)
    expect(parsed[:data][:attributes][:current_weather][:conditions]).to be_a(String)
    expect(parsed[:data][:attributes][:current_weather][:icon]).to be_a(String)
    expect(parsed[:data][:attributes]).to have_key(:daily_weather)
    expect(parsed[:data][:attributes][:daily_weather].count).to eq(5)
    parsed[:data][:attributes][:daily_weather].each do |day|
      expect(day).to have_key(:date)
      expect(day).to have_key(:sunrise)
      expect(day).to have_key(:sunset)
      expect(day).to have_key(:min_temp)
      expect(day).to have_key(:max_temp)
      expect(day).to have_key(:conditions)
      expect(day).to have_key(:icon)
      expect(day[:date]).to be_a(String)
      expect(day[:sunrise]).to be_a(String)
      expect(day[:sunset]).to be_a(String)
      expect(day[:min_temp]).to be_a(Float)
      expect(day[:max_temp]).to be_a(Float)
      expect(day[:conditions]).to be_a(String)
      expect(day[:icon]).to be_a(String)
    end
    expect(parsed[:data][:attributes]).to have_key(:hourly_weather)
    expect(parsed[:data][:attributes][:hourly_weather].count).to eq(8)
    parsed[:data][:attributes][:hourly_weather].each do |hour|
      expect(hour).to have_key(:time)
      expect(hour).to have_key(:temperature)
      expect(hour).to have_key(:conditions)
      expect(hour).to have_key(:icon)
      expect(hour[:time]).to be_a(String)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour[:conditions]).to be_a(String)
      expect(hour[:icon]).to be_a(String)
    end
    end
  end
  end
  describe 'Sad path' do
    it 'returns error status if location is bad' do
      VCR.use_cassette('bad_location_request') do
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        get '/api/v1/forecast?location=', headers: headers
        expect(response).to have_http_status(400)
        expect(response.body).to eq("Invalid location")
      end
    end
  end
end
