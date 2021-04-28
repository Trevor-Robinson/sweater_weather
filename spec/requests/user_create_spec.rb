require 'rails_helper'
RSpec.describe 'When I send a post request to api/v1/user' do
  describe 'Happy path' do
    it 'creates a user' do
      VCR.use_cassette('user_request') do
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"email": "whatever@example.com", "password": "password", "password_confirmation": "password"}
        post '/api/v1/users', headers: headers, params: body, as: :json
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
        expect(parsed[:data][:attributes][:email]).to be_a(String)
        expect(parsed[:data][:attributes]).to have_key(:api_key)
        expect(parsed[:data][:attributes][:api_key]).to be_a(String)
      end
    end
  end
  describe 'Sad path' do
    it 'returns error status if email already used' do
      VCR.use_cassette('bad_user_request_email_repeat') do
        User.create("email": "whatever@example.com", "password": "password", "password_confirmation": "password")
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"email": "whatever@example.com", "password": "password", "password_confirmation": "password"}
        post '/api/v1/users', headers: headers, params: body, as: :json
        expect(response).to have_http_status(422)
        expect(response.body).to eq("Email has already been taken")
      end
    end
    it 'returns error status if not valid email format' do
      VCR.use_cassette('bad_user_request_email_invalid') do
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"email": "whatev", "password": "password", "password_confirmation": "password"}
        post '/api/v1/users', headers: headers, params: body, as: :json
        expect(response).to have_http_status(422)
        expect(response.body).to eq("Email is invalid")
      end
    end
    it 'returns error status if passwords do not match' do
      VCR.use_cassette('bad_user_request_passwords') do
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        body = {"email": "whatev@hey.com", "password": "password", "password_confirmation": "pass"}
        post '/api/v1/users', headers: headers, params: body, as: :json
        expect(response).to have_http_status(422)
        expect(response.body).to eq("Password confirmation doesn't match Password")
      end
    end
  end
end
