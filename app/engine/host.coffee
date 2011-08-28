common = require '../common'
settings = common.settings
appDir = common.appDir

now = require 'now'
Client = require('./client').Client
World = require("#{appDir}/client/app/models/world").World

#Signal = require('signals').Signal

class Host
	constructor: (@id) ->
		@world = new World settings.world
		@world.avatarMoved.add (avatar) ->
			# send message to all clients
			
		@clients = {}
	socketConnect: (socket) =>
		client = new Client socket, @world

		@clients[client.id] = client
		client

	socketDisconnect: (socket) =>
		console.log 'DISCONNECTING SOCKET'
		client = @getClient socket
		client?.destroy()

		delete @clients[socket.id]

	getClient: (socket) =>
		@clients[socket.id]


module.exports =
	Host: Host

