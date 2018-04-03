# Admin::
module Admin
  # CountriesController
  class CountriesController < BaseController
    before_action :require_admin

    def index
      @countries = Country.all
    end
  end
end