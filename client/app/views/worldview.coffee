AvatarView = require('./avatarview').AvatarView
class WorldView
	constructor: (@world, @el) ->
		console.log "WorldView Created for world:"
		console.log @world
		@avatarViews = []
		@canvas = oCanvas.create
			canvas: @el
		@canvas.width = 600
		@canvas.height = 600
		@world.on 'avatar.added', (avatar) =>
			@addAvatarView new AvatarView(avatar)
			
			
	addAvatarView: (avatarView) =>
		@avatarViews.push(avatarView)
		avatarView.render(@canvas)
		
		
module.exports =
	WorldView: WorldView
