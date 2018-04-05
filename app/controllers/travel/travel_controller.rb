# Travel
module Travel
  # Travel Controller
  class TravelController < ApplicationController
    def new
      country1 = Country.where(
                    Country.arel_table[:name]
                      .lower
                      .matches("%#{params[:origin].downcase}%")
                  ).first
      country2 = Country.where(
                    Country.arel_table[:name]
                      .lower
                      .matches("%#{params[:destination].downcase}%")
                  ).first

      redirect_to "/travel/#{country1.code}/#{country2.code}"
    end

    def show
      @country1 = Country.find_by(code: params[:country_1])
      @country2 = Country.find_by(code: params[:country_2])

      @language_string = @country2.languages.map do |lang|
        lang.name
      end.to_sentence

      @save_params = {
        name: "My trip from #{@country1.name} to #{@country2.name}",
        origin_country: @country1,
        destination_country: @country2
      }

      render :'travel/show'
    end
  end
end
