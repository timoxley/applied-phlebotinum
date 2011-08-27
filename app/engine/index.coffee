Server = require('./client').Server

Host = require('./host').Host
Client = require('./client').Client

common = require '../common'

now = require 'now'

winston = common.winston

sys = require 'sys'

class Engine
	constructor: (app) ->
		everyone = now.initialize app
		
		@hosts = []
		@hosts.push new Host()
		
		now.on 'connect', ->
			#availableHosts = host for host in hosts when host.notFull()
			# host = availableHosts[Math.floor(Math.random(availableHosts.length))] unless availableHosts.length == 0
			winston.info 'connected: '+@user.clientId
		#	host = hosts[0]
		#	host.group.addUser @user.clientId
		#	@user.world = host.world

		now.on 'disconnect', ->
			console.log "Left : " + @now
		
		that = @	
		everyone.now.getWorld = (callback) ->
			@now.world = that.hosts[0].world
			console.log @now.world.on
			callback(@now.world)


module.exports =
	Engine: Engine