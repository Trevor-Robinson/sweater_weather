class Api::V1::RoadtripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      render json: "Unauthorized", status: 401
    else
      facade = RoadtripFacade.new
      render json: RoadtripSerializer.new(facade.get_roadtrip_details(params[:origin], params[:destination]))
    end
  end
end
