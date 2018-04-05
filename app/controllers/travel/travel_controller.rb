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

      @save_params = {
        name: "My trip from #{@country1.name} to #{@country2.name}",
        origin_country: @country1,
        destination_Country: @country_2
      }

      render :'travel/show'
    end
  end
end
