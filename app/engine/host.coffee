common = require '../common'
settings = common.settings
appDir = common.appDir

now = require 'now'

World = require("#{appDir}/client/app/models/world").World

class Host
	constructor: (@id) ->
		@group = now.getGroup @id
		@world = new World settings.world.width, settings.world.height

module.exports =
	Host: Host

