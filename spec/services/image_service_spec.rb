require 'rails_helper'

RSpec.describe 'Image Service' do
  describe 'happy path' do
    it 'returns image and user data from the api' do
      VCR.use_cassette('image_api') do
        coords = Coordinates.new({:lat=>39.738453, :lng=>-104.984853})
        search = "denver skyline"
        service = ImageService.new
        response = service.get_background(search, coords)
        expect(response).to be_a(Hash)
        expect(response.count).to eq(2)
        expect(response).to have_key(:photo)
        expect(response).to have_key(:user)
        expect(response[:photo]).to have_key(:id)
        expect(response[:photo]).to have_key(:owner)
        expect(response[:photo]).to have_key(:secret)
        expect(response[:photo]).to have_key(:server)
        expect(response[:photo]).to have_key(:farm)
        expect(response[:photo]).to have_key(:title)
        expect(response[:photo][:id]).to be_a(String)
        expect(response[:photo][:owner]).to be_a(String)
        expect(response[:photo][:secret]).to be_a(String)
        expect(response[:photo][:server]).to be_a(String)
        expect(response[:photo][:farm]).to be_a(Integer)
        expect(response[:photo][:title]).to be_a(String)
        expect(response[:user]).to have_key(:nsid)
        expect(response[:user]).to have_key(:url)
        expect(response[:user][:nsid]).to eq(response[:photo][:owner])
        expect(response[:user][:url]).to be_a(String)
      end
    end
  end
  describe 'Sad Path' do
    it 'returns error if search returns no results' do
      coords = Coordinates.new({:lat=>39.738453, :lng=>-104.984853})
      search = "daslkfjlj-0i-0il;ml;mm skyline"
      service = ImageService.new
      response = service.get_background(search, coords)
      expect(response).to be_a(Hash)
      expect(response.count).to eq(2)
      expect(response).to have_key(:status)
      expect(response[:status]).to eq(400)
      expect(response[:error]).to eq("Invalid photo search")
    end
  end
end
