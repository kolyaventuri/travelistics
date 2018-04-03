# Admin::
module Admin
  class LanguagesController < BaseController
    before_action :require_admin

    def new
      @country = Country.find(params[:country_id])
    end
  end
end