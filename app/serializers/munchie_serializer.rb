class MunchieSerializer
  def initialize(facade)
    @destination = facade.destination
    @restaurants = formatted_restaurants(facade.restaurants)
  end

  def full_response
    {
      destination: @destination,
      restaurants: @restaurants
    }
  end

  def formatted_restaurants(restaurants)
    restaurants.map do |r|
      {name: r.name, address: r.address}
    end
  end
end
