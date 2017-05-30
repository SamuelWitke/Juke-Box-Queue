# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile=["index_player/player.js"]
Rails.application.config.assets.precompile += %w( index_player/TweenMax.min.js )
Rails.application.config.assets.precompile += %w( application.css )
Rails.application.config.assets.precompile += %w( application.js ) 
Rails.application.config.assets.precompile += %w( search/classie.js )
Rails.application.config.assets.precompile += %w( search/AnimOnScroll.js)
Rails.application.config.assets.precompile += %w( search/masonry.pkgd.min.js)
Rails.application.config.assets.precompile += %w( search/modernizr.custom.js )
Rails.application.config.assets.precompile += %w( search/imagesloaded.js)
Rails.application.config.assets.precompile += %w( search/classie.js)

