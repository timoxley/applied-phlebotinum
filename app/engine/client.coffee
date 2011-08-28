common = require '../common'
_ = require 'underscore'

appDir = common.appDir
Avatar = require("#{appDir}/client/app/models/avatar").Avatar
Zombie = require("#{appDir}/client/app/models/zombie").Zombie

class Client
	assignedZombies: 5
	
	constructor: (@socket, @world) ->
		@id = @socket.id

		# Add player avatar to world
		x = Math.floor(Math.random() * 60) * 10
		y = Math.floor(Math.random() * 60) * 10
		
		@avatar = new Avatar {@id, x, y}
		@world.addActor @avatar

		# Add zombies targeting this user
		@assignZombies()

		# Send current game state to client
		socket.emit 'sendWorld', @world.serialize()
		socket.emit 'sendMyAvatar', @socket.id

		@socket.on 'updateAvatar', (data) =>
			@avatar.update data
			@socket.broadcast.emit 'updateActor', @avatar.serialize()
	
		@socket.on 'zombie-killed', (id) =>
			@world.killZombie id

	assignZombies: =>
		@assignZombie() for num in [0..@assignedZombies]

	assignZombie: =>
		x = Math.floor(Math.random() * 60) * 10
		y = Math.floor(Math.random() * 60) * 10

		zombie = new Zombie _.uniqueId(['zombie_']), x, y
		zombie.changeTarget @avatar.id

#		@world.addActor zombie

	emitEvent: (event, arguments) =>
		@socket.emit event, arguments

	destroy: =>
		@world.removeActor @id

module.exports = {Client}