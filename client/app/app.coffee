World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController

module.exports = 
	init: ->
		now.receiveWorld = ->
			console.log now.world

		now.getWorld()

			#@avatarController = new AvatarController(test1, @worldView.canvas)
#			@worldView = new WorldView(world, '#world')
