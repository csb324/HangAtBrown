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

    if @rsvp.save
      redirect_to event_rsvp_path(@event, @rsvp), notice: "Awesome!"
      send_sms(current_user, "You're hanging out with #{@event.host.first_name} today at #{@event.location.name} at #{@rsvp.arrival_time_name}. #{@event.host.first_name} will be wearing a #{@event.host_outfit}!")
    else
      flash.now[:alert] = @rsvp.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    @rsvp = Rsvp.find(params[:id])

    # Send a text if someone cancels!
    @cancellation_message = "Oh no! #{current_user.first_name} can no longer hang at #{@rsvp.arrival_time_name} at #{@event.location.name}. Hang again soon!"
    if @rsvp.creator == true
      # If the host cancels, text everyone else
      @event.users.each do |person|
        send_sms(person, @cancellation_message) unless person == current_user
      end
    else
      # If a guest cancels, only text the host
      send_sms(@event.host, @cancellation_message)
    end

    @rsvp.destroy

    redirect_to profile_path, notice: "Guess you weren't down to hang."
  end

  private
  def rsvp_params
    params.require(:rsvp).permit(:expected_arrival, :outfit, :event_id)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def send_sms(recipient, message)
    number_to_send_to = recipient.phone_number

    twilio_sid = ENV['TWILIO_ID']
    twilio_token = ENV['TWILIO_TOKEN']
    twilio_phone_number = ENV['TWILIO_NUMBER']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      from: twilio_phone_number,
      to: number_to_send_to,
      body: message
    )
  end

end
