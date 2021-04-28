class SalariesService

  def get_salaries(location)
    data = get_location_data(location)
    data[:_embedded][:"city:search-results"].first[:_embedded][:"city:item"][:_embedded][:"city:urban_area"][:_embedded][:"ua:salaries"][:salaries]
 end

  private

  def get_location_data(location)
    response = connection.get("/api/cities/") do |req|
      req.params['search'] = location
      req.params['embed'] = "city:search-results/city:item/city:urban_area/ua:salaries,"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    Faraday.new(url: 'https://api.teleport.org')
  end

end
