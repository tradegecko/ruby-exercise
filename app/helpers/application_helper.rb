module ApplicationHelper
  def time_format(datetime)
    if datetime
      datetime = DateTime.strptime(datetime, "%a %b %d %H:%M:%S %z %Y") if datetime.is_a? String
      datetime.in_time_zone("Singapore").strftime("%d %b %Y, %H:%M:%S")
    end
  end

  def time_period(datetime)
    if datetime
      datetime = DateTime.strptime(datetime, "%a %b %d %H:%M:%S %z %Y") if datetime.is_a? String
      "#{distance_of_time_in_words_to_now(datetime)} ago"
    end
  end
end
