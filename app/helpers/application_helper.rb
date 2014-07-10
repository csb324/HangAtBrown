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

end
