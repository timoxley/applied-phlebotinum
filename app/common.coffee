winston = require 'winston'
path = require 'path'

appDir = path.normalize "#{__dirname}/.."

module.exports =
	winston: winston
	appDir: appDir
	settings:
		world:
			width: 900
			height: 506
