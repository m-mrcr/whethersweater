class Api::V1::MunchiesController < ApplicationController
  def show
    munchies = MunchiesFacade.new(params)
    render json: munchies.full_response
  end
end
