AvatarView = require('./avatarview').AvatarView
class WorldView
	constructor: (@world, @el) ->
		console.log "WorldView Created for world:"
		console.log @world
		@avatarViews = []
		@canvas = oCanvas.create
			canvas: @el
		
		
		
		@world.on 'avatar.added', (avatar) =>
			@addAvatarView AvatarView.create(avatar, @canvas)
			
	addAvatarView: (avatarView) =>
		@avatarViews.push(avatarView)
		console.log avatarView
		@canvas.addChild avatarView
		
		
module.exports =
	WorldView: WorldView
