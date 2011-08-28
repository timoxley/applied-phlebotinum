AvatarView = require('./avatarview').AvatarView


class WorldView
	constructor: (@world, @el) ->
		@avatarViews = {}
		@canvas = oCanvas.create
			canvas: @el
		@canvas.width = @world.width
		@canvas.height = @world.height
		
		@addAvatarView(new AvatarView(actor, @canvas)) for id, actor of @world.actors
		
		@world.actorsAdded.add (actor) =>
			@addAvatarView new AvatarView(actor, @canvas)
		
		@world.actorsRemoved.add (avatar) =>
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
