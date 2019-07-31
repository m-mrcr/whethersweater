class Api::V1::RoadTripsController < ApplicationController
  def create
    api_key = params[:api_key]
    return unauthorized('API key must be provided') unless api_key
    user = User.find_by(api_key: api_key)
    if user
      render json: RoadTripFacade.new(user_trip_parameters)
    else
      unauthorized('Invalid API key')
    end
  end

  private

  def user_trip_parameters
    origin = params[:origin]
    destination = params[:destination]
    { origin: origin, destination: destination }
  end

  def unauthorized(message)
    render status: :unauthorized, json: { error: message }
  end
end
