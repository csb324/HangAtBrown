class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def welcome
  end

  def show
    @location = Location.find(params[:id])
  end

end
