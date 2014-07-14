class EventsController < ApplicationController

  before_action :authenticate_user!

  def show
    @event = Event.find(params[:id])
    if current_user.events.include? @event
      @my_rsvp = current_user.rsvps.select{ |rsvp| rsvp.event == @event }.first
      redirect_to event_rsvp_path(@event, @my_rsvp)
    else
      redirect_to new_event_rsvp_path(@event)
    end
  end

  def new
    @event = Event.new
    @event.rsvps.build
  end

  def create
    @event = Event.new(event_params)

    # Basic formatting inputs
    if @event.topic.present?
      @event.topic.downcase!
    end

    # Creating the automatic rsvp for the host

    @rsvp = @event.rsvps.first
    # There should only be one RSVP in the array anyways, so we only look at the first
    # If there's more than one, that's a problem!
    @rsvp.user = current_user
    @rsvp.event = @event

    @rsvp.expected_arrival = @event.start_time
    @rsvp.creator = true

    @rsvp.outfit = event_params["rsvps_attributes"]["0"]["outfit_color"].downcase +
      " " + event_params["rsvps_attributes"]["0"]["outfit_object"].downcase

    if @event.save && @rsvp.save
      redirect_to @event.location, notice: "Event saved!"
    else
      flash.now[:alert] = @event.errors.full_messages.join(", ")
      render :new
    end
  end

  private
  def event_params
    params.require(:event).permit(:start_time, :end_time, :location_id, :topic, :event_type, rsvps_attributes: [:outfit_object, :outfit_color])
  end

  def outfit_params
    params.require(:event).permit(:outfit_color, :outfit_object)
  end

end
