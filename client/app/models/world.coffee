#EventEmitter2 = require('eventemitter2').EventEmitter2

class World
	constructor: (@el) ->
		console.log "World Created"
		
		
module.exports =
	World: World
