module Admin
  # CurrencyController
  class CurrenciesController < BaseController
    before_action :require_admin

    def index
      @currencies = Currency.all
    end

    def edit
      @currency = Currency.find(params[:id])
    end

    def update
      @currency = Currency.find(params[:id])
      @currency.update(currency_params)

      if @currency.save
        redirect_to admin_currencies_path
      else
        flash[:error] = 'An error occured.'
        render :edit
      end
    end

    private

    def currency_params
      params.require(:currency).permit(:code)
    end
  end
end
