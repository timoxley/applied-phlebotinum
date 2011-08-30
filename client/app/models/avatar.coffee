Actor = require('./actor').Actor

class Avatar extends Actor
	type: 'Avatar'
	constructor: ->
		super
		@changed.add =>
			collisions = actor for id, actor of @world.actors when actor.type is 'Zombie'
			
			if collisions? > 0
				@died.dispatch()
				@dead = true
module.exports = {Avatar}
