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
			
		socket.on 'sendMyAvatar', (avatarId) =>
			@me = @world.getActor avatarId
			@me.movementBus = new Signal()
			@me.movementBus.add (avatar) =>
				socket.emit 'updateAvatar',
					x: avatar.x
					y: avatar.y
			@me.me = true
			@me.changed.dispatch()
			new AvatarController(@me, @worldView.canvas)
		socket.on 'updateActor', (data) =>
			@world.getActor(data.id)?.update(data)
		socket.on 'newAvatar', (data) =>
			@world.addActor new Avatar(data)
		socket.on 'removeAvatar', (id) =>
			@world.removeActor(id)
	
module.exports = {App}

