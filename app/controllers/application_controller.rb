class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def authenticate_user!
    redirect_to signin_path unless signed_in?
  end

  def set_time_zone
    Time.use_zone(current_user.time_zone) { yield }
  end
end
