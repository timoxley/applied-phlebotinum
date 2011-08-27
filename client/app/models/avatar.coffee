
World = require('./models/world').World
Signal = undefined

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Avatar
	constructor: (@name) ->
		console.log "Avatar Created: #{name}"
		@x = Math.floor(Math.random() * 60) * 10
		@y = Math.floor(Math.random() * 60) * 10
		
		@changed = new Signal()

module.exports =
	Avatar: Avatar
