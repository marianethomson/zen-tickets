module ApplicationHelper
  def parse_time(time)
      local_time = Time.parse(time) + 10.hours
      local_time.strftime('%e %b %Y %H:%M:%S%p')
  end
end