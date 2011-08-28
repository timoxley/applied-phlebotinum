
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: ({@id, @x, @y}) ->
		@changed = new Signal()
	serialize: =>
		out =
			x: @x
			y: @y
			id: @id
module.exports =
	Avatar: Avatar
