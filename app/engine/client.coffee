common = require '../common'
appDir = common.appDir
Avatar = require("#{appDir}/client/app/models/avatar").Avatar

class Client
	constructor: (@socket, @world) ->
		@id = @socket.id

		# Add player avatar to world
		x = Math.floor(Math.random() * 60) * 10
		y = Math.floor(Math.random() * 60) * 10
		@world.addAvatar new Avatar {@id, x, y}

		# Send current game state to client
		socket.emit 'sendWorld', @world.serialize()

		@socket.on 'player-moved', (x, y) =>
			@world.movePlayer @id, x, y

		@socket.on 'zombie-killed', (id) =>
			@world.killZombie id

	destroy: =>
		@world.removeAvatar @id

module.exports = {Client}