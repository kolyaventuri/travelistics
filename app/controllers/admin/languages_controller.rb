module Admin
  # LanguagesContoller
  class LanguagesController < BaseController
    before_action :require_admin

    def index
      @languages = Language.all
    end

    def destroy
      language = Language.find(params[:id])
      flash[:error] = 'Could not delete language.' unless language.destroy
      redirect_to admin_languages_path
    end

    def edit
      @language = Language.find(params[:id])
    end
  end
end
