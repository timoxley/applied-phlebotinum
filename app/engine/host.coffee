common = require '../common'
settings = common.settings
appDir = common.appDir

Client = require('./client').Client
World = require("#{appDir}/client/app/models/world").World

class Host
	constructor: (@id) ->
		@world = new World settings.world
		@world.avatarChanged.add (avatar) =>
			@broadcast avatar.id, 'updateAvatar', avatar.serialize()
		@clients = {}

	socketConnect: (socket) =>
		console.log socket
		client = new Client socket, @world
		@clients[client.id] = client
		@broadcast client.avatar.id, 'newAvatar', client.avatar.serialize()
		client

	socketDisconnect: (socket) =>
		console.log 'DISCONNECTING SOCKET'
		client = @getClient socket
		client?.destroy()
		@broadcast client.id, 'removeAvatar', client.id
		delete @clients[client.id]

	getClient: (socket) =>
		@clients[socket.id]

	broadcast: (from, event, arguments) =>
		(client.emitEvent event, arguments) for id, client of @clients when id isnt from



module.exports =
	Host: Host

