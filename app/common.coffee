winston = require 'winston'
path = require 'path'



module.exports =
	winston: winston
	appDir: path.normalize "#{__dirname}/.."
	settings = 
		world:
			width: 600
			height: 600
