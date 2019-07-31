class GoogleMaps < Base
  attr_reader :location, :origin, :destination
  def initialize(input)
    @location = input[:location]
    @origin = input[:origin]
    @destination = input[:destination]
  end

  def geocoding_response
    get_json('maps/api/geocode/json', address: @location)
  end

  def directions_response
    params = {
                origin: @origin,
                destination: @destination
             }
    get_json('maps/api/directions/json', params)
  end

  private

  def conn
    Faraday.new('https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
    end
  end
end
