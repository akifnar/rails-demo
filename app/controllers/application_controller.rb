class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_visit_counter
  private
  def set_visit_counter
    if session[:counter].nil?
        session[:counter] = 0
        session[:last_visit] = Time.now

    else
        session[:counter] += 1
    end
      @session_counter =  session[:counter]
  end
end
