class RoadTripSerializer
  def initialize(facade)
    @travel_time = facade.estimated_travel_time
    @forecast_data = facade.destination_forecast
  end

  def full_response
    {
      travel_time: @travel_time,
      temperature: @forecast_data[:temperature],
      summary: @forecast_data[:summary]
    }
  end

end
