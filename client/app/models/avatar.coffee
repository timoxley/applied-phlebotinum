
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: ({@userId, @x, @y}) ->
		console.log "Avatar Created: #{@userId}"
		@x ?= Math.floor(Math.random() * 60) * 10
		@y ?= Math.floor(Math.random() * 60) * 10
		
		@changed = new Signal()

module.exports =
	Avatar: Avatar
