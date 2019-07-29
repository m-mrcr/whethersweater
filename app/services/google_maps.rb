class GoogleMaps
  attr_reader :location
  def initialize(location)
    @location = location[:location]
  end

  def geocoding_response
    get_json('maps/api/geocode/json', address: @location)
  end

  private

  def get_json(uri, params = {})
    response = conn.get uri, params
    JSON.parse response.body, symbolize_names: true
  end

  def conn
    Faraday.new('https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
    end
  end
end
