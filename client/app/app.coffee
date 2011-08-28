World = require('./models/world').World
WorldView = require('./views/worldview').WorldView
Avatar = require('./models/avatar').Avatar
AvatarController = require('./controllers/avatarcontroller').AvatarController

_ = require 'underscore'

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class App
	constructor: ->
		@socket = io.connect "http://#{window.location.hostname}"

		@socket.on 'disconnect', =>
			@world.removeActor(@socket.id)

		@socket.on 'sendWorld', (worldData) =>
			@world = new World(worldData)
			@worldView = new WorldView(@world, '#world')
		@socket.on 'updateActors', (actors) =>
			for actor in actors when actor.id isnt @me.id
				if @world.getActor(actor.id)?
					@world.getActor(actor.id).update actor
				else
					@world.addActor @world.createActor actor
			
		@socket.on 'sendMyAvatar', (avatarId) =>
			@me = @world.getActor avatarId
			update = _.throttle (avatar) =>
				console.log('updateAvatar')
				@socket.emit 'updateAvatar',
					x: avatar.x
					y: avatar.y
			, 250
			@me.movementBus.add (avatar) =>
				update(avatar)
			@me.me = true
			@me.changed.dispatch()
			new AvatarController(@me, @worldView.canvas)
		@socket.on 'updateActor', (data) =>
			console.log('updateActor')
			@world.getActor(data.id)?.update(data)

		@socket.on 'newActor', (data) =>
			@world.addActor @world.createActor(data)
		@socket.on 'removeActor', (id) =>
			@world.removeActor(id)
	
module.exports = {App}

