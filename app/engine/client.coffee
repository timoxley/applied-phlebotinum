common = require '../common'
_ = require 'underscore'

appDir = common.appDir
Avatar = require("#{appDir}/client/app/models/avatar").Avatar
Zombie = require("#{appDir}/client/app/models/zombie").Zombie

class Client
	assignedZombies: 5
	activeZombies: 0
	kills: 0
	
	constructor: (@socket, @world) ->
		@id = @socket.id

		# Add player avatar to world
		x = Math.floor(Math.random() * 200) + (common.settings.world.width / 2) - (200 / 2)
		y = Math.floor(Math.random() * 150) + (common.settings.world.height / 2) - (150 / 2)
		
		@avatar = new Avatar {@id, x, y}
		@world.addActor @avatar

		# Add zombies to target this user
		@assignZombies()
		setTimeout =>
			@assignZombies()
		, 5000

		# Send current game state to client
		socket.emit 'sendWorld', @world.serialize()
		socket.emit 'sendMyAvatar', @socket.id

		@socket.on 'updateAvatar', (data) =>
			@avatar.update data
			@socket.broadcast.emit 'updateActor', @avatar.serialize()
			
	
		@socket.on 'killZombie', (id) =>
			@world.killActor id
			@kills += 1
			@socket.broadcast.emit 'removeActor', id

	assignZombies: =>
		zombiesNeeded = @assignedZombies - @activeZombies
		@assignZombie() for num in [0..zombiesNeeded-1]

	assignZombie: =>
		x = Math.random() * common.settings.world.width
		y = Math.random() * common.settings.world.height
		switch (Math.round(Math.random() * 3))
			when 0
				x = 0
			when 1
				y = 0
			when 2
				x = common.settings.world.width
			when 3
				y = common.settings.world.height
		id = _.uniqueId(['zombie_'])

		zombie = new Zombie {id, x, y}
		zombie.setTarget @avatar.id

		@world.addActor zombie
		@socket.broadcast.emit 'newActor', zombie.serialize()
		@activeZombies += 1

	emitEvent: (event, arguments) =>
		@socket.emit event, arguments

	destroy: =>
		@world.removeActor @id

module.exports = {Client}