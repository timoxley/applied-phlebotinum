AvatarView = require('./avatarview').AvatarView


class WorldView
	constructor: (@world, @el) ->
		@avatarViews = {}
		@canvas = oCanvas.create
			canvas: @el
		@canvas.width = @world.width
		@canvas.height = @world.height
		
		@addAvatarView(new AvatarView(avatar, @canvas)) for id, avatar of @world.avatars
		
		@world.avatarAdded.add (avatar) =>
			@addAvatarView new AvatarView(avatar, @canvas)
		
		@world.avatarRemoved.add (avatar) =>
			@removeAvatarView avatar
		
	addAvatarView: (avatarView) =>
		@avatarViews[avatarView.avatar.id] = avatarView
		
	removeAvatarView: (avatar) =>
		@avatarViews[avatar.id].destroy()
		delete @avatarViews[avatar.id]
		
	render: =>
		avatarView.render()
		
module.exports =
	WorldView: WorldView
