# Travel
module Travel
  # Travel Controller
  class TravelController < ApplicationController
    def show
      @country1 = Country.find(params[:country_1])
      @country2 = Country.find(params[:country_2])

      @language_string = @country2.languages.map do |lang|
        lang.name
      end.to_sentence

      render :'travel/show'
    end
  end
end
