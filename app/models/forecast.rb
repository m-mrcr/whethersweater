class Forecast
  def initialize(data)
    @data = data
  end

  def currently
    {
      summary: @data[:currently][:summary],
      icon: @data[:currently][:icon],
      temperature: @data[:currently][:temperature],
      feels_like: @data[:currently][:apparentTemperature],
      humidity: @data[:currently][:humidity],
      visibility: @data[:currently][:visibility],
      uv_index: @data[:currently][:uvIndex],
      high: @data[:daily][:data].first[:temperatureHigh],
      low: @data[:daily][:data].first[:temperatureLow]
    }
  end

  def hourly
    hourly = {}
    @data[:hourly][:data][0..7].each do |h|
      hour = {
        time: h[:time],
        icon: h[:icon],
        temperature: h[:temperature]
      }
      hourly[h[:time]] = hour
    end
    hourly
  end

  def daily
    daily = {}
    @data[:daily][:data][1..5].each do |d|
      day = {
        date: d[:time],
        icon: d[:icon],
        recip_probability: d[:recipProbability],
        high: d[:temperatureHigh],
        low: d[:temperatureLow]
      }
      daily[d[:time]] = day
    end
    daily
  end

end
