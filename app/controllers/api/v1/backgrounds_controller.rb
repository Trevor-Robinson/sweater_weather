class Api::V1::BackgroundsController < ApplicationController
  def show
    background = BackgroundFacade.new
    render json: BackgroundSerializer.new(background.background(params[:location]))
  end
end
