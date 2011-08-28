Server = require('./client').Server

Host = require('./host').Host
Client = require('./client').Client

common = require '../common'

now = require 'now'

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
			console.log socket
			host = @selectHost()
			host.addClient new Client(socket)
			console.log host
			socket.emit 'sendWorld', host.world.serialize()
			# host.addClient()
	selectHost: =>
		@host 
		# socket.emit('news', { hello: 'world' });
		# socket.on('my other event', function (data) {
		#   console.log(data);

module.exports =
	Engine: Engine