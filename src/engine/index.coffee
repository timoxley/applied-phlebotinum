Server = require('./client').Server


init ->
	server = new Server


module.exports
	init: init