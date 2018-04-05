# TripController
class TripsController < ApplicationController
  before_action :require_login

  def index
    @trips = Trip.where(user: current_user)
  end

  def show
    @trip = Trip.where(id: params[:id], user: current_user).first

    return redirect_to trips_path unless @trip
  end

  def destroy
    trip = Trip.where(id: params[:id], user: current_user).first

    return redirect_to trips_path unless trip

    flash[:error] = 'Something went wrong.' unless trip.destroy

    redirect_to trips_path
  end
end
