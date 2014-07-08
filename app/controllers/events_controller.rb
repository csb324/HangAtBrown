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
    if @event.topic.present?
      @event.topic.downcase!
    end

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
    params.require(:event).permit(:start_time, :end_time, :location_id, :topic, rsvps_attributes: [:outfit])
  end

end
