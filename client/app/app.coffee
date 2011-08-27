World = require('./models/world').World
WorldView = require('./views/worldview').WorldView

module.exports = 
	init: ->	
		World = new World(new WorldView())