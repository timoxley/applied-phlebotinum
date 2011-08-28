AvatarView = require('./avatarview').AvatarView
ZombieView = require('./zombieview').ZombieView


class WorldView
	constructor: (@world, @el) ->
		@actorViews = {}
		@canvas = oCanvas.create
			canvas: @el
		@canvas.width = @world.width
		@canvas.height = @world.height
		
		@addActorView( @createActorView actor, @canvas ) for id, actor of @world.actors
		
		@world.actorsAdded.add (actor) =>
			@addActorView( @createActorView actor, @canvas )
		
		@world.actorsRemoved.add (avatar) =>
			@removeActorView avatar
		
	addActorView: (actorView) =>
		@actorViews[actorView.actor.id] = actorView

	removeActorView: (actor) =>
		@actorViews[actor.id].destroy()
		delete @actorViews[actor.id]

	createActorView: (actor, canvas) ->
		switch actor.type
			when 'Avatar' then new AvatarView(actor, canvas)
			when 'Zombie' then new ZombieView(actor, canvas)
			else null

	render: =>
		

module.exports =
	WorldView: WorldView
