AvatarView = require('./avatarview').AvatarView


class WorldView
	constructor: (@world, @el) ->
		console.log "WorldView Created for world:"
		@avatarViews = []
		@canvas = oCanvas.create
			canvas: @el
		@canvas.width = @world.width
		
		@canvas.height = @world.height
		@world.avatarAdded.add (avatar) =>
			@addAvatarView new AvatarView(avatar, @canvas)
		@world.avatarRemoved.add (avatar) =>
			@addAvatarView new AvatarView(avatar, @canvas)	
	addAvatarView: (avatarView) =>
		@avatarViews[avatarView.avatar.userId] = avatarView
		avatarView.render()
	removeAvatarView: (avatarView) =>
		delete @avatarViews[avatarView.avatar.userId]
		
		
module.exports =
	WorldView: WorldView
