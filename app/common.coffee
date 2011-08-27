winston = require 'winston'
path = require 'path'



module.exports =
	winston: winston
	appDir: path.normalize "#{__dirname}/.."
