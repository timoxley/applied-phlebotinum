AvatarView = require('./avatarview').AvatarView


class WorldView
	constructor: (@world, @el) ->
		console.log "WorldView Created for world:"
		console.log @world
		@avatarViews = []
		@canvas = oCanvas.create
			canvas: @el
		@canvas.width = @world.width
		@canvas.height = @world.height
		console.log @world.avatarAdded
		@world.avatarAdded.add (avatar) =>
			@addAvatarView new AvatarView(avatar, @canvas)
			
	addAvatarView: (avatarView) =>
		@avatarViews.push(avatarView)
		avatarView.render()
		
		
module.exports =
	WorldView: WorldView
