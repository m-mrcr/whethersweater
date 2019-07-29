class Api::V1::ForecastsController < ApplicationController
  def show
    forecast = ForecastFacade.new(params[:location])
    render json: forecast.full_response
  end
end
