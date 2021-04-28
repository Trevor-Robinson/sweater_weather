require 'rails_helper'
RSpec.describe Image do
  it 'makes Image object from data' do
    image_data = {:photo=>
  {:id=>"50948688121",
   :owner=>"91357526@N00",
   :secret=>"7511ec5d52",
   :server=>"65535",
   :farm=>66,
   :title=>"Denver at Early Evening (6.46pm Pano), 15 July 2020",
   :ispublic=>1,
   :isfriend=>0,
   :isfamily=>0},
 :user=>{:nsid=>"91357526@N00", :url=>"https://www.flickr.com/people/rock_chalk_jhawk_ku/"}}
    location = "denver,co"
    url = "https://live.staticflickr.com/65535/50948688121_7511ec5d52_b.jpg"
    result = Image.new(image_data, url, location)
    expect(result).to be_a(Image)
    expect(result.image_url).to eq("https://live.staticflickr.com/65535/50948688121_7511ec5d52_b.jpg")
    expect(result.location).to eq("denver,co")
    expect(result.credit).to be_a(Credit)
    expect(result.credit.author).to eq("rock_chalk_jhawk_ku")
    expect(result.credit.author_profile).to eq("https://www.flickr.com/people/rock_chalk_jhawk_ku/")
    expect(result.credit.notice).to eq("This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.")
    expect(result.credit.source).to eq("flickr.com")
  end
end
