class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  before_action :authorize

  rescue_from StandardError, with: :handle_exception

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

  def handle_exception(exception)
    ErrorMailer.error_notification(exception.message, exception.backtrace).deliver_later
    respond_to  do |format|

      format.turbo_stream {
        flash.now[:notice] = "Application Failure"
        render turbo_stream: turbo_stream.replace("notice", partial: "store/notice")
      }
      format.html { redirect_to store_index_url, notice: "Application Failure" }
      format.json { render json: { error: "Application Failure" }, status: :internal_server_error }
    end
  end

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
