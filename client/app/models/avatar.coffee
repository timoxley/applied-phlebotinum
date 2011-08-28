
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: ({@id, @x, @y}) ->
		@changed = new Signal()
		console.log(arguments)
		console.log(@)
	serialize: =>
		console.log 'serialise:'
		out =
			id: @id
			x: @x
			y: @y
		console.log out
		out


module.exports =
	Avatar: Avatar
