EventEmitter2 = require('eventemitter2').EventEmitter2

Client = require('./client').Client

class Server extends EventEmitter2
	clients: []
	
	constructor: ->
		# Do stuff



module.exports =
	Server: Server