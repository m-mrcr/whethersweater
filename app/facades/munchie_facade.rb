class MunchieFacade
  include DirectionsMethods

  attr_reader :destination

  def initialize(input)
    @origin = input[:start]
    @destination = input[:end]
    @food_term = input[:food]
  end

  def restaurants
    yelp.get_restaurants.map do |r|
      Restaurant.new(r)
    end
  end

  private

  def yelp
    params = {
      location: @destination,
      food: @food_term,
      arrival_time: arrival_time
    }
    Yelp.new(params)
  end
end
