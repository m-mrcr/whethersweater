class ForecastFacade
  def initialize(location)
    @location = location
  end

  def full_response
    parameters = {
      google_results: google_results,
      forecast_data: forecast_data
    }
  end

  private

  def google_geocoding
    params = { location: @location }
    @google_geocoding ||= GoogleMaps.new(params)
  end

  def google_results
    @google_results ||= google_geocoding.results
  end

  def get_coordinates
    @coordinates ||= google_results[:results].first[:geometry][:location]
  end

  def dark_sky
    @dark_sky ||= DarkSky.new(get_coordinates)
  end

  def forecast_data
    @forecast_data ||= dark_sky.forecast
  end
end
