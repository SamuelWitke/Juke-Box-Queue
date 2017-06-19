require_relative 'boot'
require 'rails/all'
require './lib/SpotifyClient.rb'
require './lib/Player.rb'
require 'rspotify'


# Require the gems listed in Gemfile, including any gems

# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VoteSongQueue
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
	config.after_initialize do
        config.client = SpotifyClient::Client.new
   end
	if defined?(Rails::Server)
  		config.after_initialize do
  			puts "Enter Client ID Created @ https://developer.spotify.com/"
  			client_id = STDIN.gets
  			puts "Enter Client Secret"
  			client_secret= STDIN.gets
  			RSpotify.authenticate(client_id.chomp,client_secret.chomp)
  		end
	end
  
end
end
