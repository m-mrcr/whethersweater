class DarkSky
  attr_reader :latitude, :longitude
  def initialize(coordinates)
    @latitude = coordinates[:lat]
    @longitude = coordinates[:lng]
  end

  def forecast
    get_json("/forecast/#{ENV['DARK_SKY_API_KEY']}/#{@latitude},#{@longitude}")
  end

  private

  def get_json(uri, params = {})
    response = conn.get uri, params
    JSON.parse response.body, symbolize_names: true
  end

  def conn
    Faraday.new('https://api.darksky.net') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
