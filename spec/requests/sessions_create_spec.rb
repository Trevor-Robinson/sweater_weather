require 'rails_helper'
RSpec.describe 'When I send a post request to api/v1/sessions' do
  describe 'Happy path' do
    it 'returns a user' do
      VCR.use_cassette('session_request') do
        user = User.create("email": "whatever@example.com", "password": "password", "password_confirmation": "password")
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"email": "whatever@example.com", "password": "password"}
        post '/api/v1/sessions', headers: headers, params: body, as: :json
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(parsed).to be_a(Hash)
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data]).to have_key(:id)
        expect(parsed[:data][:id]).to be_a(String)
        expect(parsed[:data]).to have_key(:type)
        expect(parsed[:data][:type]).to eq("users")
        expect(parsed[:data]).to have_key(:attributes)
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes]).to have_key(:email)
        expect(parsed[:data][:attributes][:email]).to eq(user.email)
        expect(parsed[:data][:attributes]).to have_key(:api_key)
        expect(parsed[:data][:attributes][:api_key]).to eq(user.api_key)
      end
    end
  end
  describe 'Sad path' do
    it 'returns error status if login incorrect' do
      VCR.use_cassette('bad_session_request') do
        User.create("email": "whatever@example.com", "password": "password", "password_confirmation": "password")
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"email": "whatever@example.com", "password": "pass"}
        post '/api/v1/sessions', headers: headers, params: body, as: :json
        expect(response).to have_http_status(401)
        expect(response.body).to eq("Invalid Credentials")
      end
    end
  end
end
