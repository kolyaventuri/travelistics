# Travel
module Travel
  # Travel Controller
  class TravelController < ApplicationController
    def show
      @country1 = Country.find(params[:country_1])
      @country2 = Country.find(params[:country_2])

      render :'travel/show'
    end
  end
end
