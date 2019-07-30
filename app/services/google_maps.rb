class GoogleMaps
  attr_reader :location, :origin, :destination
  def initialize(input)
    @location = input[:location]
    @origin = input[:start]
    @destination = input[:end]
  end

  def geocoding_response
    get_json('maps/api/geocode/json', address: @location)
  end

  def trip_results
    params = {
      origin: @origin,
      destination: @destination
    }
    get_json('maps/api/directions/json', params)
  end

  private

  def duration
    @duration ||= trip_results[:routes].first[:legs].first[:duration][:value]
  end

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
