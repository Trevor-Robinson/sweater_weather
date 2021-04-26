class Credit
  def initialize(data)
    @author = get_author(data)
    @author_profile = data[:user][:url]
    @source = "flickr.com"
    @notice = "This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc."
  end

  def get_author(data)
    data[:user][:url].split('/').last
  end
end
