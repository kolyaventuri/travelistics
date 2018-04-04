module Admin
  # LanguagesContoller
  class LanguagesController < BaseController
    before_action :require_admin

    def index
      @languages = Language.all
    end
  end
end