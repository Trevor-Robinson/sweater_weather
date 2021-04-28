require 'rails_helper'
RSpec.describe 'When I send a get request to api/v1/background' do
  describe 'Happy path' do
    it 'returns a background ' do
      VCR.use_cassette('background_request') do
      headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
      get '/api/v1/backgrounds?location=denver,co', headers: headers
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(parsed).to be_a(Hash)
      expect(parsed[:data]).to be_a(Hash)
      expect(parsed[:data]).to have_key(:id)
      expect(parsed[:data][:id]).to be_nil
      expect(parsed[:data]).to have_key(:type)
      expect(parsed[:data][:type]).to eq("image")
      expect(parsed[:data]).to have_key(:attributes)
      expect(parsed[:data][:attributes]).to have_key(:location)
      expect(parsed[:data][:attributes]).to have_key(:image_url)
      expect(parsed[:data][:attributes]).to have_key(:credit)
      expect(parsed[:data][:attributes][:credit]).to have_key(:author)
      expect(parsed[:data][:attributes][:credit]).to have_key(:author_profile)
      expect(parsed[:data][:attributes][:credit]).to have_key(:source)
      expect(parsed[:data][:attributes][:credit]).to have_key(:notice)
      expect(parsed[:data][:attributes][:location]).to be_a(String)
      expect(parsed[:data][:attributes][:image_url]).to be_a(String)
      expect(parsed[:data][:attributes]).to have_key(:credit)
      expect(parsed[:data][:attributes][:credit][:author]).to be_a(String)
      expect(parsed[:data][:attributes][:credit][:author_profile]).to be_a(String)
      expect(parsed[:data][:attributes][:credit][:source]).to be_a(String)
      expect(parsed[:data][:attributes][:credit][:notice]).to be_a(String)
      end
    end
  end
  describe 'Sad path' do
    it 'returns error status if location is bad' do
      VCR.use_cassette('bad_background_request') do
        headers = {'CONTENT_TYPE' => 'application/json', ACCEPT: 'application/json'}
        get '/api/v1/backgrounds?location=', headers: headers
        expect(response).to have_http_status(400)
        expect(response.body).to eq("Invalid location")
      end
    end
  end
end
