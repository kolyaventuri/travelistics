# Admin::
module Admin
  class CountryLanguagesController < BaseController
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

    def destroy
      country = Country.find(params[:country_id])
      languages_with_removed = country.languages.reject do |language|
        language.id == params[:language_id].to_i
      end

      country.languages = languages_with_removed

      flash[:error] = 'Something went wrong.' unless country.save
      redirect_to edit_admin_country_path(country)
    end

    private

    def language_params
      params.require(:language).permit(:name)
    end
  end
end