World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController

class App 
	constructor: ->
		that = this
		now.getWorld (worldData) ->
			that.world = new World(worldData)
			that.worldView = new WorldView(world, '#world')
			

			
			#@avatarController = new AvatarController(test1, @worldView.canvas)
		now.getAvatar (avatar) ->
			that.addAvatar new Avatar(avatar)
module.exports = {App}

