module Admin
  class CurrenciesController < BaseController
    before_action :require_admin

    def index
      @currencies = Currency.all
    end
  end
end