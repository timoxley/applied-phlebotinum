Server = require('./client').Server

Host = require('./host').Host
Client = require('./client').Client

common = require '../common'

#now = common.now

sys = require 'sys'

hosts ?= []




module.exports =
	newGame: ->
		hosts.push new Host hosts.length