module SongsHelper
	def playTop
	if Rails.application.config.client == nil
        Rails.application.config.client = SpotifyClient::Client.new
    end
	if(Rails.application.config.client.status['playing'])
		puts "No need to get SOng"
	else 
		puts " PLASEAE get otuerh song"
    end 
	end
end
