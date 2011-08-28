common = require '../common'
settings = common.settings
appDir = common.appDir

Client = require('./client').Client
World = require("#{appDir}/client/app/models/world").World

class Host
	constructor: (@id) ->
		@world = new World settings.world
		@clients = {}

	socketConnect: (socket) =>
		console.log socket
		client = new Client socket, @world
		@clients[client.id] = client
		socket.broadcast.emit 'newAvatar', client.avatar.serialize()
		client

	socketDisconnect: (socket) =>
		console.log 'DISCONNECTING SOCKET'
		client = @getClient socket
		client.destroy()
		socket.broadcast.emit 'removeAvatar', client.avatar.id
		delete @clients[client.id]

	getClient: (socket) =>
		@clients[socket.id]

	broadcast: (from, event, arguments) =>
		(client.emitEvent event, arguments) for id, client of @clients when id isnt from



module.exports =
	Host: Host

