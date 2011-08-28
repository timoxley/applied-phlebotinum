
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: ({@id, @x, @y, @health}) ->
		@health ?= 100
		@changed = new Signal()
		@died = new Signal()
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
	adjustHealth: (value) =>
		@health += value
		if @health <= 0
			died.dispatch @
		
		@movementBus.dispatch @
		@changed.dispatch()
module.exports =
	Avatar: Avatar
