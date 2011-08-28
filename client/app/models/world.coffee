_ = require 'underscore'

Avatar = require('./avatar').Avatar
Zombie = require('./avatar').Zombie

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
			(console.log actor) for id, actor of actors
			(@addActor new Avatar(actor)) for id, actor of actors

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

	serialize: =>
		out =
			width: @width
			height: @height
			actors: (actor.serialize()) for id, actor of @actors  
module.exports = {World}
