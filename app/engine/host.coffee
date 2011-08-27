EventEmitter2 = require('eventemitter2').EventEmitter2


common = require '../common'
appDir = common.appDir

World = require("#{appDir}/client/models/world").World

class Host extends EventEmitter2
	
	constructor: ->
		@world = new World settings.world.width, settings.world.height

		# @world.addAvatar new Avatar('test 2')
		# @world.addAvatar new Avatar('test 3')
		save()
	save: =>
		


module.exports =
	Host: Host