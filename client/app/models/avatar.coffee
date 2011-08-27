EventEmitter2 = require('eventemitter2').EventEmitter2

class Avatar extends EventEmitter2
	constructor: (@name) ->
		console.log "Avatar Created: #{name}"
		
module.exports =
	Avatar: Avatar
