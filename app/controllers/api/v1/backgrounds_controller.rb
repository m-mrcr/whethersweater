class Api::V1::BackgroundsController < ApplicationController
  def show
    unsplash = Unsplash.new
    render json: unsplash.image(params[:location])
  end
end
