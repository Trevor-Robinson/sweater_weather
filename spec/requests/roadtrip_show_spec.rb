require 'rails_helper'
RSpec.describe 'When I send a post request to api/v1/road_trip' do
  describe 'Happy path' do
    it 'creates a user' do
      VCR.use_cassette('roadtrip_request') do
        user = User.create("email": "whatever@example.com", "password": "password", "password_confirmation": "password")
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"origin": "Denver,CO", "destination": "Pueblo,CO", "api_key": user.api_key}
        post '/api/v1/road_trip', headers: headers, params: body, as: :json
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(parsed).to be_a(Hash)
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data]).to have_key(:id)
        expect(parsed[:data][:id]).to be_nil
        expect(parsed[:data]).to have_key(:type)
        expect(parsed[:data][:type]).to eq("roadtrip")
        expect(parsed[:data]).to have_key(:attributes)
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes]).to have_key(:start_city)
        expect(parsed[:data][:attributes][:start_city]).to eq("Denver,CO")
        expect(parsed[:data][:attributes]).to have_key(:end_city)
        expect(parsed[:data][:attributes][:end_city]).to eq("Pueblo,CO")
        expect(parsed[:data][:attributes]).to have_key(:travel_time)
        expect(parsed[:data][:attributes][:travel_time]).to be_a(String)
        expect(parsed[:data][:attributes]).to have_key(:weather_at_eta)
        expect(parsed[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(parsed[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        expect(parsed[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
        expect(parsed[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(parsed[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      end
    end
  end
  describe 'Sad path' do
    it 'returns error status if api_key invalid' do
      VCR.use_cassette('bad_session_request') do
        User.create("email": "whatever@example.com", "password": "password", "password_confirmation": "password")
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"origin": "Denver,CO", "destination": "Pueblo,CO", "api_key": "jgn983hy48thw9begh98h4539h4"}
        post '/api/v1/road_trip', headers: headers, params: body, as: :json
        expect(response).to have_http_status(401)
        expect(response.body).to eq("Unauthorized")
      end
    end
    it 'returns error if trip invalid' do
      VCR.use_cassette('bad_session_request') do
        user = User.create("email": "whatever@example.com", "password": "password", "password_confirmation": "password")
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"origin": "Denver,CO", "destination": "London,UK", "api_key": user.api_key}
        post '/api/v1/road_trip', headers: headers, params: body, as: :json
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(parsed).to be_a(Hash)
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data]).to have_key(:id)
        expect(parsed[:data][:id]).to be_nil
        expect(parsed[:data]).to have_key(:type)
        expect(parsed[:data][:type]).to eq("roadtrip")
        expect(parsed[:data]).to have_key(:attributes)
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes]).to have_key(:start_city)
        expect(parsed[:data][:attributes][:start_city]).to eq("Denver,CO")
        expect(parsed[:data][:attributes]).to have_key(:end_city)
        expect(parsed[:data][:attributes][:end_city]).to eq("London,UK")
        expect(parsed[:data][:attributes]).to have_key(:travel_time)
        expect(parsed[:data][:attributes][:travel_time]).to eq("impossible route")
        expect(parsed[:data][:attributes]).to have_key(:weather_at_eta)
        expect(parsed[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(parsed[:data][:attributes][:weather_at_eta].empty?).to eq(true)
      end
    end
  end
end
