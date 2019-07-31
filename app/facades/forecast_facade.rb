class ForecastFacade
  include ForecastMethods
  def initialize(location)
    @location = location
  end

  def full_response
    {
      location_data: geocoding,
      forecast_data: formatted_forecast
    }
  end
end
