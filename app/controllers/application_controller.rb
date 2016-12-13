class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def authenticate_user!
    redirect_to signin_path unless signed_in?
  end
end
