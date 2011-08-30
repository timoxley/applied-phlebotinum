
_ = require 'underscore'

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Actor
	UP: 0
	DOWN: 1
	LEFT: 2
	RIGHT: 3
	type: null

	constructor: ({@id, @x, @y, @health, @me}) ->
		@health ?= 100
		@changed = new Signal()
		@dead = false
		@movementBus = new Signal()
		@died = new Signal()
		@max_speed = 60
		@min_movement = 3
		@isMoving = false
		@direction = Actor.DOWN

	collidesWith: (actor) =>
		(actor.x - 20 < @.x < actor.x + 20 and actor.y - 20 < @.y < actor.y)
	serialize:  =>
		out =
			id: @id
			x: @x
			y: @y
			health: @health
			type: @type
			
	move: ({x, y}) =>
		if x? and 0 <= @x + x <= @world.width
			@x += x
		if y? and 0 <= @y + y <= @world.height
			@y += y

		@movementBus?.dispatch @
		@isMoving = true
		
		@changed.dispatch()
	stop: =>
		@isMoving = false
		@changed.dispatch 'stop'
	update: ({@x, @y, @health}) =>
		console.log('updated')
		@changed.dispatch()
#	adjustHealth: (value) =>
#		@health += value
#		if @health <= 0
#			died.dispatch @

module.exports = {Actor}
