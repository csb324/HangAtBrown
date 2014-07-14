module ApplicationHelper
  def nice_time(time)
    time.strftime("%l:%M %p")
  end

  # Twilio!
  def send_sms(message, phone_number: nil, recipient: nil)
    if phone_number.present?
      number_to_send_to = phone_number
      address = phone_number
    elsif recipient.present?
      number_to_send_to = recipient.phone_number
      address = recipient.first_name
    end

    addressed_message = "#{address}: #{message}"

    twilio_sid = ENV['TWILIO_ID']
    twilio_token = ENV['TWILIO_TOKEN']
    twilio_phone_number = ENV['TWILIO_NUMBER']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      from: twilio_phone_number,
      to: number_to_send_to,
      body: addressed_message
    )
  end

  # This is to help with generating time dropdown menus
  def possible_times_after(given_min_time, given_max_time: nil)
    all_possible_times = []

    # If the given time is in the past, add "now" to the menu
    if given_min_time < Time.zone.now
      all_possible_times << ["right now", Time.zone.now + 2.minutes]
      # And set the minimum time to now
      min_time = Time.zone.now
    else
    # Otherwise set the minimum time to whatever is given
      min_time = given_min_time
    end

    possible_hours = (Time.zone.now.hour...24)
    # Increment minutes by five
    possible_minutes = (0...12).map { |i| i*5 }

    possible_hours.each do |hour|
      possible_minutes.each do |min|
        # This generates a time - date is today by default
        t = Time.new.change(hour: hour, min: min)

        # if T isn't before the official begin-time
        if t > min_time
          # and as long as t isn't greater than the max time, if there is one
          unless given_max_time.present? && t > given_max_time
            # make a name for the time and add the name/time to the array
            timename = nice_time(t)
            all_possible_times << [timename, t]
          end # unless
        end # if t > mintime
      end # minutes.each
    end #hours.each

    all_possible_times
    # return the array (of pairs of arrays)

    # LORD KNOWS THERE'S A BETTER WAY TO DO THIS USING JAVASCRIPT
    # BUT THIS WORKS AND IT'S CLEANER ON THE USER-SIDE SO DEAL.
  end

end
