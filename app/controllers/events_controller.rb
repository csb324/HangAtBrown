class EventsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @event = Event.new

  end

  def create
    @event = Event.new(event_params)
    @rsvp = Rsvp.new(user: current_user, event: @event, expected_arrival: event_params[:start_time], outfit: event_params[:outfit], creator: true)

    if @rsvp.save && @event.save
      redirect_to root_path
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
    params.require(:event).permit(:start_time, :end_time, :location, :outfit, :topic)
  end

end
