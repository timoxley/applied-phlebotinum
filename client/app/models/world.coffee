Avatar = require('./avatar').Avatar
Zombie = require('./zombie').Zombie

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@id, @height, @width, actors}) ->
		@actorsAdded = new Signal()
		@actorsRemoved = new Signal()
		@actorsChanged = new Signal()
				
		@actors = {}
		if actors?
			(@addActor @createActor actor) for id, actor of actors
			

	addActor: (actor) =>
		@actors[actor.id] = actor
		@actorsAdded.dispatch actor
		actor.changed.add =>
			@actorsChanged.dispatch actor
		
		actor.world = @
		actor
		
	removeActor: (id) =>
		@actorsRemoved.dispatch @actors[id]
		delete @actors[id]

	getActor: (id) =>
		@actors[id] || null

	createActor: (actor) =>
		switch actor.type
			when 'Avatar' then new Avatar(actor)
			when 'Zombie' then new Zombie(actor)
			else null
	killActor: (id) ->
		actor = @getActor id
		@actorsRemoved.dispatch @actors[id]

		if actor.type = 'Zombie'
			targetingClient = @getActor zombie.target
			if targetingClient
				targetingClient.activeZombies -= 1

	serialize: =>
		out =
			width: @width
			height: @height
			actors: (actor.serialize()) for id, actor of @actors
	update: ({@width, @height, actors}) =>
		for actor in actors
			if @getActor(actor.id)?
				@getActor(actor.id).update(actor)
			else
				@addActor @createActor actor
		
module.exports = {World}
