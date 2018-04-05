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

  def create
    trip = Trip.new(trip_params)

    flash[:error] = 'Something went wrong and we werent able to save that trip.' unless trip.save

    redirect_to trips_path
  end

  def destroy
    trip = Trip.where(id: params[:id], user: current_user).first

    return redirect_to trips_path unless trip

    flash[:error] = 'Something went wrong.' unless trip.destroy

    redirect_to trips_path
  end

  private

  def trip_params
    data = params.permit(:name, :origin_country, :destination_country)
    data[:origin_country] = Country.find(data[:origin_country].to_i)
    data[:destination_country] = Country.find(data[:destination_country].to_i)
    data[:user] = current_user
    data.to_h
  end
end
