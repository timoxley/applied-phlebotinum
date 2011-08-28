
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: ({@userId, @x, @y}) ->
		@changed = new Signal()

module.exports =
	Avatar: Avatar
