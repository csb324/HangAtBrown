class RsvpsController < ApplicationController

  before_action :set_event

  def show
    @rsvp = Rsvp.find(params[:id])
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    @rsvp.user = current_user
    @rsvp.event = @event

    if @rsvp.save
      redirect_to event_rsvp_path(@event, @rsvp), notice: "Awesome!"
    else
      flash.now[:alert] = @rsvp.errors.full_messages.join(", ")
      render :new
    end
  end

  private
  def rsvp_params
    params.require(:rsvp).permit(:expected_arrival, :outfit, :event_id)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

end
