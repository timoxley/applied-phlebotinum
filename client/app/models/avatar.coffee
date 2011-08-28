
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: ({@id, @x, @y}) ->
		@changed = new Signal()
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
		@changed.dispatch()
module.exports =
	Avatar: Avatar
