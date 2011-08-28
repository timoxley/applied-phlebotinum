
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
		@died = new Signal()
		@max_speed = 60
		@min_movement = 3
		@isMoving = false
		@direction = Actor.DOWN
	serialize: =>
		out =
			id: @id
			x: @x
			y: @y
			type: @type
			
	move: ({x, y}) =>
		if x? and 0 < @x + x < @world.width
			@x += x
		if y? and 0 < @y + y < @world.height
			@y += y
		@movementBus.dispatch @
		@isMoving = true
		@changed.dispatch 'start'
	stop: =>
		@isMoving = false
		@changed.dispatch 'stop'
	update: ({@x, @y, @health}) =>
		@changed.dispatch()
	adjustHealth: (value) =>
		@health += value
		if @health <= 0
			died.dispatch @

module.exports = {Actor}
