module TimeFormatHelper
  def nice_time(time)
    time.strftime("%l:%M %p")
  end
end
