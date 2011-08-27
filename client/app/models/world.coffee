EventEmitter2 = require 'eventemitter2'

class World
	constructor: (@el) ->
		console.log "World Created"
		
		
module.exports =
	World: World
#exports = World