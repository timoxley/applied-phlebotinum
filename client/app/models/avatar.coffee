
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: ({@id, @x, @y, @health}) ->
		@health ?= 100
		@changed = new Signal()
		@died = new Signal()
		@max_speed = 10
	serialize: =>
		out =
			id: @id
			x: @x
			y: @y
	move: ({x, y}) =>
		if x?
			@x += x
		if y?
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
	
module.exports =
	Avatar: Avatar
