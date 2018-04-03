# Admin::
module Admin
  # Base
  class BaseController < ApplicationController
    def require_admin
      render file: '/public/404' unless current_admin?
    end

    private

    def current_admin?
      current_user && current_user.admin?
    end
  end
end
