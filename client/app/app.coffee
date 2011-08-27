World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController

module.exports = 
	init: ->
		now.getWorld (worldData) ->
			world = new World(worldData)
			@worldView = new WorldView(world, '#world')
			
			#@avatarController = new AvatarController(test1, @worldView.canvas)
#			
