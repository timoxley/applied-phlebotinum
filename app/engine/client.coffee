common = require '../common'
appDir = common.appDir
Avatar = require("#{appDir}/client/app/models/avatar").Avatar

class Client
	constructor: (@socket, @world) ->
		@id = @socket.id

		# Add player avatar to world
		x = Math.floor(Math.random() * 60) * 10
		y = Math.floor(Math.random() * 60) * 10
		@avatar = new Avatar {@id, x, y}
		@world.addAvatar @avatar

		# Send current game state to client
		socket.emit 'sendWorld', @world.serialize()
		socket.emit 'sendPlayer', @socket.id
		
		@socket.on 'player-moved', ({x, y}) =>
			@avatar.move x, y

		@socket.on 'zombie-killed', (id) =>
			@world.killZombie id

	emitEvent: (event, arguments)=>
		@socket.emit event, arguments

	destroy: =>
		@world.removeAvatar @id

module.exports = {Client}