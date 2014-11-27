module ApplicationHelper
  def time_format(datetime)
    if datetime
      datetime.localtime.strftime("%d %b %Y, %H:%M:%S")
    end
  end

  def time_period(datetime)
    if datetime
      "#{distance_of_time_in_words_to_now(datetime)} ago"
    end
  end
end
