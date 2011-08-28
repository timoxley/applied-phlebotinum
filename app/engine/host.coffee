common = require '../common'
settings = common.settings
appDir = common.appDir

now = require 'now'
Avatar = require("#{appDir}/client/app/models/avatar").Avatar
World = require("#{appDir}/client/app/models/world").World

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal

class Host
	constructor: (@id) ->
		@world = new World settings.world
		@clients = {}
	addClient: (client) =>
		console.log "client:"
		console.log client
		@clients[client.id] = client
		
		@world.addAvatar new Avatar
			id: client.id


	removeClient: (client) =>
		@world.removeAvatar client.id
		delete	@clients[client.id]


module.exports =
	Host: Host

