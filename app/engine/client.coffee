EventEmitter2 = require('eventemitter2').EventEmitter2

class Client extends EventEmitter2
	constructor: (@id) ->
		# Do stuff
		

module.exports =
	Client: Client