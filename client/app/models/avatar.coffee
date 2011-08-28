
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
module.exports =
	Avatar: Avatar
