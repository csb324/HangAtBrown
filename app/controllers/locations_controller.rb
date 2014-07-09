class LocationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    @events = @location.events.select{ |e| e.end_time > Time.now }
  end

end
