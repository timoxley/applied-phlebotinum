common = require '../common'
settings = common.settings
appDir = common.appDir

now = require 'now'

World = require("#{appDir}/client/app/models/world").World

class Host
	constructor: (@id, @everyone) ->
		@group = now.getGroup @id
		@world = new World settings.world
		
	addUser: (@userId) ->
		@group.addUser userId
		@world.addUser userId

	removeUser: (@userId) ->
		@group.removeUser userId
		@world.removeUser userId

module.exports =
	Host: Host

