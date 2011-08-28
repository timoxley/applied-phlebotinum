World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController

class App 
	constructor: ->
		socket = io.connect("http://#{window.location.hostname}");
		socket.on 'sendWorld', (worldData) ->
			@world = new World(worldData)
			@worldView = new WorldView(@world, '#world')
			console.log(worldData)
		    # socket.emit('my other event', { my: 'data' });



		# now.getAvatar (avatar) ->
		# 	that.addAvatar new Avatar(avatar)
module.exports = {App}

