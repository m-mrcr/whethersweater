module DirectionMethods
  private

  def arrival_time
    Time.now.to_i + travel_time
  end

  def travel_time
    directions_response[:routes].first[:legs].first[:duration][:value]
  end

  def directions_response
    @directions_response ||= directions_api.directions_response
  end

  def directions_api
    parameters = { origin: @origin, destination: @destination}
    @directions_api ||= GoogleMaps.new(parameters)
  end
end
