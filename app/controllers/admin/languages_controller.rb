module Admin
  # LanguagesContoller
  class LanguagesController < BaseController
    before_action :require_admin

    def index
      @languages = Language.all
    end

    def new
      @language = Language.new
    end

    def create
      @language = Language.new(language_params)

      if @language.save
        redirect_to admin_languages_path
      else
        flash[:error] = 'An error occured.'
        render :new
      end
    end

    def destroy
      language = Language.find(params[:id])
      flash[:error] = 'Could not delete language.' unless language.destroy
      redirect_to admin_languages_path
    end

    def edit
      @language = Language.find(params[:id])
    end

    def update
      @language = Language.find(params[:id])
      @language.update(language_params)

      if @language.save
        redirect_to admin_languages_path
      else
        flash[:error] = 'An error was encountered.'
        render :edit
      end
    end

    private

    def language_params
      params.require(:language).permit(:name, :code)
    end
  end
end
