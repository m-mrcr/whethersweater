class Api::V1::BackgroundsController < ApplicationController
  def show
    unsplash = Unsplash.new
    render json: {image: unsplash.image(params[:location])}
  end
end
