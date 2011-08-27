common = require '../common'
#now = common.now
settings = common.settings
appDir = common.appDir

World = require("#{appDir}/client/app/models/world").World

#everyone = common.everyone

class Host
	constructor: (@id) ->
#    @group = now.getGroup @id
#    @world = new World settings.world.width, settings.world.height

module.exports =
	Host: Host

