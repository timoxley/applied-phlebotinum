Server = require('./client').Server

Host = require('./host').Host

common = require '../common'

winston = common.winston

class Engine
	constructor: (app) ->
		@host = new Host 0
		@clients = {}
		io = require('socket.io').listen(app)
		io.enable 'browser client minification'
		io.enable 'browser client etag'
		io.set 'log level', 3
		io.set 'transports', [
			'websocket'
			'flashsocket'
			'htmlfile'
			'xhr-polling'
			'jsonp-polling'
		]
		io.sockets.on 'connection', (socket) =>
			client = @host.socketConnect socket

			socket.on 'disconnect', (id) =>
				@host.socketDisconnect socket
		
		# socket.emit('news', { hello: 'world' });
		# socket.on('my other event', function (data) {
		#   console.log(data);

module.exports =
	Engine: Engine