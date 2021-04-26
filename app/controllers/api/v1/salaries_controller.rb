class Api::V1::SalariesController < ApplicationController
  def show
    facade = SalariesFacade.new
    salaries = facade.get_data(params[:destination])

  end
end
