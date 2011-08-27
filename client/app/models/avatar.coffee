EventEmitter2 = require('eventemitter2').EventEmitter2

class Avatar extends EventEmitter2
	constructor: (@name) ->
		console.log "Avatar Created: #{name}"
		@x = Math.random() * 200
		@y = Math.random() * 200

module.exports =
	Avatar: Avatar
