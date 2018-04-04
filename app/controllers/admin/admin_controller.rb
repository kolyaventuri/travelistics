# Admin::
module Admin
  # AdminController
  class AdminController < BaseController
    before_action :require_admin

    def index
    end
  end
end