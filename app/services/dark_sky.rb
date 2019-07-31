class DarkSky < Base
  attr_reader :latitude, :longitude
  def initialize(attributes)
    @latitude = attributes[:lat]
    @longitude = attributes[:lng]
  end

  def forecast(time = nil)
    get_json(path(time))
  end

  private

  def path(time = nil)
    path = "/forecast/#{ENV['DARK_SKY_API_KEY']}/#{@latitude},#{@longitude}"
    path + ",#{time}" if time
    path
  end

  def conn
    Faraday.new('https://api.darksky.net') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
