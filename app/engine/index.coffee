Server = require('./client').Server

Host = require('./host').Host

now = require 'now'

sys = require 'sys'

hosts ?= []

now.on 'connect', ->
	#availableHosts = host for host in hosts when host.notFull()
	# host = availableHosts[Math.floor(Math.random(availableHosts.length))] unless availableHosts.length == 0
	
	
	nowjs.getGroup(0).addUser(@user.clientId)
	this.now.host = hosts
	
now.on 'disconnect', ->
	console.log "Left : " + @now


module.exports =
	newGame: ->
		hosts.push new Host hosts.length