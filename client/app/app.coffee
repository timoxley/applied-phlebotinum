World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController
settings = require 'settings'

module.exports = 
	init: ->
		@world = now.world
		#@avatarController = new AvatarController(test1, @worldView.canvas) 
		@worldView = new WorldView(@world, '#world')
