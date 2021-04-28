class Image
  attr_reader :location,
              :image_url,
              :credit,
              :id
  def initialize(image_data, url, location)
    @id = id
    @location = location
    @image_url = url
    @credit = Credit.new(image_data[:user])
  end
end
