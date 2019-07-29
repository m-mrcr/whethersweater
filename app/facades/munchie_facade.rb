class MunchieFacade
  def initialize(input)
    @start = input[:start]
    @end = input[:end]
    @food = input[:food]
  end

  def full_response
    params = {
      destination: @end,
      restaurants: processed_restaurants,
    }
  end

  private

  def processed_restaurants
    restaurants = []
    get_restaurants.each do |r|
      name = r[:name]
      address = r[:location][:display_address]
      restaurants << {name: name, address: format_address(address)}
    end
    restaurants
  end

  def format_address(input)
    street = input.first
    city = input.second
    address = street + ", " + city
  end

  def get_restaurants
    params = {
      term: @food,
      location: @end,
      open_at: (Time.now + trip.trip_duration.seconds).to_i,
      limit: 3
    }
    yelp.get_json('/v3/businesses/search', params)[:businesses]
  end

  def trip
    params = {
      start: @start,
      end: @end
    }
    @trip ||= GoogleGeocoding.new(params)
  end

  def yelp
    Yelp.new
  end
end
