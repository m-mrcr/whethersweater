class Api::V1::MunchiesController < ApplicationController
  def show
    facade = MunchieFacade.new(params)
    render json: MunchieSerializer.new(facade).full_response
  end
end
