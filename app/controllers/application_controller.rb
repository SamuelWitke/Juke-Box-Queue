class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :mobile_device?

  protected
# Get current song playing to display in /index
  def get_current
	if(Rails.application.config.client.status == nil)
		flash[:error] = 'Spotify App Not Connected'
		return
	end
	if(Rails.application.config.client.status['playing'])
		track =  Rails.application.config.client.status['track']['track_resource']['name']
		length = Rails.application.config.client.status['track']['length'] 
		track = Song.find_by_track(track)
		track = {
				id: track.id,
				track: track.track,
				artists: track.artists,
				url: track.url,
				username: track.user.username,
				length: length
		}
		return track
	else
		return  Song.new()
	end
  end

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
	prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
	end
  end

 def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
 end

end
