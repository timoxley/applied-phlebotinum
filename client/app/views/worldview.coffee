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
		
		@addAvatarView(new AvatarView(avatar, @canvas)) for id, avatar of @world.avatars
		
		@world.avatarAdded.add (avatar) =>
			@addAvatarView new AvatarView(avatar, @canvas)
		# 
		@world.avatarRemoved.add (avatar) =>
			@addAvatarView new AvatarView(avatar, @canvas)
		
	addAvatarView: (avatarView) =>
		console.log('addAvatarView')
		@avatarViews[avatarView.avatar.userId] = avatarView
		
	removeAvatarView: (avatarView) =>
		delete @avatarViews[avatarView.avatar.userId]
		
	render: =>
		avatarView.render()
		
module.exports =
	WorldView: WorldView
