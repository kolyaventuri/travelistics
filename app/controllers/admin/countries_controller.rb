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
  end
end
