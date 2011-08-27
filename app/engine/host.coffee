common = require '../common'
settings = common.settings
appDir = common.appDir

now = require 'now'

World = require("#{appDir}/client/app/models/world").World

class Host
	constructor: (@id) ->
		@group = now.getGroup @id
		@world = new World settings.world
	addUser: (@userId) ->
		@group.addUser userId
		@world.avatars.push userId
	removeUser: (@userId) ->
		@group.removeUser userId
		@world.avatars.splice(@world.avatars.indexOf(userId), 1)
module.exports =
	Host: Host

