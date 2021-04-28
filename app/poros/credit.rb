class Credit
  attr_reader :author,
              :author_profile,
              :source,
              :notice
  def initialize(data)
    @author = data[:url].split('/').last
    @author_profile = data[:url]
    @source = "flickr.com"
    @notice = "This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc."
  end
end
