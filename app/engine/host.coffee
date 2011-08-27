EventEmitter2 = require('eventemitter2').EventEmitter2


common = require '../common'
appDir = common.appDir

World = require("#{appDir}/client/models/world").World

now = require 'now'

everyone = common.everyone

class Host extends EventEmitter2
	
	constructor: (@id) ->
		@world = new World settings.world.width, settings.world.height

		# @world.addAvatar new Avatar('test 2')
		# @world.addAvatar new Avatar('test 3')
		save()
	save: =>
		now.getGroup


module.exports =
	Host: Host