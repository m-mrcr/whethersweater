class ForecastFacade
  def initialize(location)
    @location = location
  end

  def full_response
    parameters = {
      location_data: geocoding,
      forecast_data: forecast_data
    }
  end

  private

  def get_geocoding
    params = { location: @location }
    @get_geocoding ||= GoogleMaps.new(params)
  end

  def geocoding
    @geocoding ||= get_geocoding.geocoding_response
  end

  def get_coordinates
    @coordinates ||= geocoding[:results].first[:geometry][:location]
  end

  def dark_sky
    @dark_sky ||= DarkSky.new(get_coordinates)
  end

  def forecast_data
    @forecast_data ||= dark_sky.forecast
  end
end
