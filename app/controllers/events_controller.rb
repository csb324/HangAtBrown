class EventsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
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

    # There should only be one RSVP in the array anyways, so we only look at the first
    # If there's more than one, that's a problem!
    @rsvp = @event.rsvps.first
    @rsvp.user = current_user
    @rsvp.event = @event

    @rsvp.expected_arrival = @event.start_time
    @rsvp.creator = true

    @location = @event.location

    if @event.save
      redirect_to @location, notice: "Event saved!"
    else
      flash.now[:alert] = @event.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def event_params
    params.require(:event).permit(:start_time, :end_time, :location_id, :topic, :event_type, rsvps_attributes: [:outfit])
  end

end
