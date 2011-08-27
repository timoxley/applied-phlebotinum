World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar

module.exports = 
	init: ->	
		@world = new World()
		console.log @world
		@worldView = new WorldView(@world, '#world')
		
		@world.addAvatar new Avatar('test 1')
		@world.addAvatar new Avatar('test 2')
		@world.addAvatar new Avatar('test 3')