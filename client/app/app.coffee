World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class App
	constructor: ->
		socket = io.connect "http://#{window.location.hostname}"
		
		socket.on 'sendWorld', (worldData) =>
			@world = new World(worldData)
			
			@worldView = new WorldView(@world, '#world')
			console.log(worldData)
		socket.on 'sendMyAvatar', (avatarId) =>
			@me = @world.avatars[avatarId]
			@me.movementBus = new Signal()
			@me.movementBus.add (avatar) =>
				socket.emit 'updateAvatar',
					x: avatar.x
					y: avatar.y
			@me.me = true
			new AvatarController(@me, @worldView.canvas)
		socket.on 'updateAvatar', (data) =>
			@world.avatars[data.id]?.update(data)
		socket.on 'newAvatar', (data) =>
			@world.addAvatar new Avatar(data)
		socket.on 'removeAvatar', (id) =>
			@world.removeAvatar(id)
	
module.exports = {App}

