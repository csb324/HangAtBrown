class RsvpsController < ApplicationController

  before_action :set_event
  before_action :authenticate_user!

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

    @rsvp.outfit = configured_outfit

    if @rsvp.save
      redirect_to event_rsvp_path(@event, @rsvp), notice: "Awesome!"
      send_confirmation_texts(@event, @rsvp)
    else
      flash.now[:alert] = @rsvp.errors.full_messages.join(", ")
      render :new
    end
  end

  def set_new_rsvp_details(rsvp)
    rsvp.user = current_user
    rsvp.event = @event
    rsvp.outfit = configured_outfit
  end

  def configured_outfit
    rsvp_params["outfit_color"].downcase + " " + rsvp_params["outfit_object"]
  end

  def send_confirmation_texts(event, rsvp)
    send_sms(
      "You're hanging out with #{event.host.first_name} today at #{event.location.name} at #{rsvp.arrival_time_name}. #{event.host.first_name} will be wearing a #{event.host_outfit}!",
      recipient: current_user
    )
    send_sms(
      "You've got a hang! #{current_user.first_name} is wearing a #{rsvp.outfit}, and will be at #{event.location.name} at #{rsvp.arrival_time_name}",
      recipient: event.host
    )
  end


  def destroy
    @rsvp = Rsvp.find(params[:id])

    # Hang @ brown will send you a text if someone cancels on you!
    alert_cancellation(@rsvp)

    if @rsvp.creator == true
      @event.destroy
    end

    @rsvp.destroy
    redirect_to profile_path, notice: "Guess you weren't down to hang."
  end

  def alert_cancellation(rsvp)
    message = "Oh no! #{current_user.first_name} can no longer hang at #{rsvp.arrival_time_name} at #{@event.location.name}. Hang again soon!"
    if rsvp.creator == true
      @event.users.each do |person|
        send_sms(message, recipient: person) unless person == current_user
      end
    else
      send_sms(message, recipient: @event.host)
    end
  end

  private
  def rsvp_params
    params.require(:rsvp).permit(:expected_arrival, :event_id, :outfit_color, :outfit_object)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
