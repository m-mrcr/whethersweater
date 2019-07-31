class ForecastFacade
  include ForecastMethods
  def initialize(location)
    @location = location
  end

  def full_response
    parameters = {
      location_data: geocoding,
      forecast_data: forecast_data
    }
  end
end
