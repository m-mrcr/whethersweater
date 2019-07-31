class ForecastSerializer
  def initialize(facade)
    @facade = facade.full_response
  end

  def full_response
    {
      location: @facade[:location_data][:results].first[:formatted_address],
      currently: @facade[:forecast_data].currently,
      hourly: @facade[:forecast_data].hourly,
      daily: @facade[:forecast_data].daily
    }
  end
end
