Server = require('./client').Server

Host = require('./host').Host

common = require '../common'

winston = common.winston

class Engine
	constructor: (app) ->
		@host = new Host 0
		@clients = {}
		io = require('socket.io').listen(app)

		io.sockets.on 'connection', (socket) =>
			client = @host.socketConnect socket

			socket.on 'disconnect', (id) =>
				@host.socketDisconnect socket
		
		# socket.emit('news', { hello: 'world' });
		# socket.on('my other event', function (data) {
		#   console.log(data);

module.exports =
	Engine: Engine