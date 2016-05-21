# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( RGraph.pie.js )
Rails.application.config.assets.precompile += %w( RGraph.line.js )
Rails.application.config.assets.precompile += %w( RGraph.common.dynamic.js )
Rails.application.config.assets.precompile += %w( RGraph.common.tooltips.js )
Rails.application.config.assets.precompile += %w( RGraph.common.key.js )
Rails.application.config.assets.precompile += %w( RGraph.common.effects.js )
Rails.application.config.assets.precompile += %w( RGraph.common.core.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.background.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.circle.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.image.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.marker1.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.marker2.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.marker3.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.poly.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.rect.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.text.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.xaxis.js )
Rails.application.config.assets.precompile += %w( RGraph.drawing.yaxis.js )