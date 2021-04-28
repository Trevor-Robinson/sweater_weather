require 'rails_helper'
RSpec.describe Credit do
  it 'makes Credit object from data' do
    data = {:nsid=>"91357526@N00", :url=>"https://www.flickr.com/people/rock_chalk_jhawk_ku/"}

    result = Credit.new(data)
    expect(result).to be_a(Credit)
    expect(result.author).to eq("rock_chalk_jhawk_ku")
    expect(result.author_profile).to eq("https://www.flickr.com/people/rock_chalk_jhawk_ku/")
    expect(result.notice).to eq("This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.")
    expect(result.source).to eq("flickr.com")
  end
end
