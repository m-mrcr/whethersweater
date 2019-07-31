module ForecastMethods
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

  def forecast_data(time = nil)
    @forecast_data ||= dark_sky.forecast(time)
  end

  def formatted_forecast
    @formattd_forecast ||= Forecast.new(forecast_data)
  end
end
