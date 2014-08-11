class LocationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @locations = Location.includes(:events).all
  end

  def show
    @location = Location.includes(:events, :rsvps).find(params[:id])
    @current_events = @location.current_events.sort_by { |e| e.end_time }
    @future_events = @location.future_events.sort_by { |e| e.start_time }
  end

end
