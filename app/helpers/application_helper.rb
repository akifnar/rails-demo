module ApplicationHelper
  def current_time
    Time.now.strftime("%H:%M")
  end
end
