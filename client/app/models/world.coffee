EventEmitter2 = require('eventemitter2').EventEmitter2

class World extends EventEmitter2
	
	constructor: () ->
		console.log "World Created"
		#@event = new EventEmitter2()
		
module.exports =
	World: World
