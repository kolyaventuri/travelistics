# Admin::
module Admin
  class LanguagesController < BaseController
    before_action :require_admin

    def new
      @country = Country.find(params[:country_id])
      @language = Language.new
      @languages = Language.all
    end

    def create
      country = Country.find(params[:country_id])
      language = Language.find(language_params[:name])

      if country && country.valid?
        country.languages << language
        if country.save
          redirect_to edit_admin_country_path(country)
        else
          flash[:error] = 'Something went wrong'
          render :new
        end
      else
        redirect_to admin_country_path
      end
    end

    private
    def language_params
      params.require(:language).permit(:name)
    end
  end
end