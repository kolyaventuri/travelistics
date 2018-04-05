# TripController
class TripsController < ApplicationController
  before_action :require_login

  def index
    @trips = Trip.where(user: current_user)
  end
end
