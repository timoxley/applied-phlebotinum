World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController

class App 
	constructor: ->
		socket = io.connect("http://#{window.location.hostname}")
		socket.on 'sendWorld', (worldData) =>
			@world = new World(worldData)
			@worldView = new WorldView(@world, '#world')
			console.log(worldData)
		socket.on 'sendPlayer', (avatarId) =>
			@me = @world.avatars[avatarId]
			new AvatarController(@me, @worldView.canvas)
module.exports = {App}

