# Admin::
module Admin
  # CountriesController
  class CountriesController < BaseController
    before_action :require_admin

    def index
      @countries = Country.all
    end

    def show
      @country = Country.find(params[:id])
    end

    def edit
      @country = Country.find(params[:id])
      @currencies = Currency.all
    end

    def update
      country = Country.find(params[:id])
      country.update(country_params)

      if country.save
        flash[:info] = "#{country.name} was updated"
        redirect_to admin_country_path(country)
      else
        flash[:error] = 'Something went wrong'
        render :edit
      end
    end

    private

    def country_params
      params_with_cur = params.require(:country).permit(:name, :code, :side_of_road, :currency)
      params_with_cur[:currency] = Currency.find(params_with_cur[:currency].to_i) if params_with_cur[:currency]
      params_with_cur
    end
  end
end
