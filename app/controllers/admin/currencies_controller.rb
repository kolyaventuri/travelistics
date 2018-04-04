module Admin
  class CurrenciesController < BaseController
    before_action :require_admin

    def index
      @currencies = Currency.all
    end

    def edit
      @currency = Currency.find(params[:id])
    end
  end
end