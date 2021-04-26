class Image
  attr_reader :location,
              :image_url,
              :credit,
              :id
  def initialize(image_data, location, user)
    @id = id
    @location = location
    @image_url = create_url(image_data)
    @credit = Credit.new(user)
  end

  def create_url(image_data)
    "https://live.staticflickr.com/#{image_data[:server]}/#{image_data[:id]}_#{image_data[:secret]}_b.jpg"
  end
end
