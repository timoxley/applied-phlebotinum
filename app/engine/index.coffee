Server = require('./client').Server

Host = require('./host').Host

common = require '../common'

winston = common.winston

class Engine
	constructor: (app) ->
		@hosts = {}
		@host = new Host @hosts.length
		@hosts[@host.id] = @host
		# 
		# host.newClient.add (client) ->
		# 	socket

		io = require('socket.io').listen(app)

		io.sockets.on 'connection', (socket) =>
			host = @selectHost()
			client = host.socketConnect socket

			socket.on 'disconnect', (id) =>
				host.socketDisconnect socket

	selectHost: =>
		@host
		
		# socket.emit('news', { hello: 'world' });
		# socket.on('my other event', function (data) {
		#   console.log(data);

module.exports =
	Engine: Engine