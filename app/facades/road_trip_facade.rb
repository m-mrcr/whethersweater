class RoadTripFacade
  include DirectionsMethods
  include ForecastMethods

  def initialize(attributes)
    @origin = attributes[:origin]
    @destination = attributes[:destination]
    @location = attributes[:destination]
  end

  def destination_forecast
    forecast = forecast_data(arrival_time)
    summary = forecast[:currently][:summary]
    temperature = forecast[:currently][:temperature]
    {summary: summary, temperature: temperature}
  end

  def estimated_travel_time
    time = Time.at(travel_time).utc.strftime("%H:%M:%S").split(':')
    return "#{time[0]} hour(s), #{time[1]} minute(s)"
  end
end
