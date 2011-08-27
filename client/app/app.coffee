World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController
settings = require 'settings'

module.exports = 
	init: ->
		console.log settings
		@world = new World settings.world.width, settings.world.height
		@worldView = new WorldView(@world, '#world')
		
		test1 = @world.addAvatar new Avatar('test 1')
		@world.addAvatar new Avatar('test 2')
		@world.addAvatar new Avatar('test 3')
		@avatarController = new AvatarController(test1, @worldView.canvas)