class RoadTripFacade
  def initialize(user_trip_parameters)
    @origin = user_trip_parameters[:origin]
    @destination = user_trip_parameters[:destination]
  end
end
