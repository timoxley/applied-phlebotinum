World = require('./models/world').World
WorldView = require('./views/worldview').WorldView

module.exports = 
	init: ->	
		world = new World()
		worldView = new WorldView(world, '#world')