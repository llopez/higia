class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || profile_path
  end

  def after_sign_out_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || new_user_session_path
  end
end
