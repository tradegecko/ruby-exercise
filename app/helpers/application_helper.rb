module ApplicationHelper
  def time_format(datetime)
    datetime.localtime.strftime("%d %b %Y, %H:%M:%S")
  end
end
