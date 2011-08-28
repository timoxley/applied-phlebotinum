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
		socket = io.connect("http://#{window.location.hostname}")
		
		
		socket.on 'sendWorld', (worldData) =>
			@world = new World(worldData)
			
			@worldView = new WorldView(@world, '#world')

		socket.on 'sendPlayer', (avatarId) =>
			@me = @world.avatars[avatarId]
			@me.movementBus = new Signal()
			@me.movementBus.add (avatar) =>
				console.log 'moved:'
				console.log avatar
				socket.emit 'playerMove',
					x: avatar.x,
					y: avatar.y
			new AvatarController(@me, @worldView.canvas)

module.exports = {App}

