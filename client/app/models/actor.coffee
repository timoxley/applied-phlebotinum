try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Actor
	constructor: ({@id, @x, @y, @health}) ->
		@health ?= 100
		@changed = new Signal()
		@died = new Signal()
		@max_speed = 60
	serialize: =>
		out =
			id: @id
			x: @x
			y: @y
	move: ({x, y}) =>
		if x? and 0 < @x + x < @world.width
			@x += x
		if y? and 0 < @y + y < @world.height
			@y += y
		@movementBus.dispatch @
		@changed.dispatch 'start'
	stop: =>
		@changed.dispatch 'stop'
	update: ({@x, @y, @health}) =>
		@changed.dispatch()
	adjustHealth: (value) =>
		@health += value
		if @health <= 0
			died.dispatch @

module.exports = {Actor}
