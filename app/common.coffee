winston = require 'winston'
path = require 'path'



module.exports =
	winston: winston
	appDir: path.normalize "#{__dirname}/.."
	settings:
		world:
			width: 695
			height: 605
