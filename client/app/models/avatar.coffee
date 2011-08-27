EventEmitter2 = require('eventemitter2').EventEmitter2

class Avatar extends EventEmitter2
	constructor: (@name) ->
		console.log "Avatar Created: #{name}"
		@x = Math.floor(Math.random() * 60) * 10
		@y = Math.floor(Math.random() * 60) * 10

	changed: => 
		@emit 'avatar.change'
	
module.exports =
	Avatar: Avatar
