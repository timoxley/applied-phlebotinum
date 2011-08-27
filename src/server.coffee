http = require('http')
nko = require('nko')('ahE2gHoOKLxdrUI0')
coffee = require('coffee-script')

common = require('./app/common')

# Winston does logging
winston = common.winston

appDir = common.appDir

# allows us to write client-side commonjs modules
stitch = require('stitch')

express = require('express')
fs = require('fs')
path = require('path')

# view libs
stylus = require('stylus')
nib = require('nib')

# utility helper. If dir exists return true
directoryExists = (dir) ->
	try
		fs.statSync dir
		return true
	catch err
		return false

# Stitch configuration
package = stitch.createPackage
	paths: ["#{appDir}/client/app", "#{appDir}/client/app/", path.resolve(require.resolve('eventemitter2'), '..')]

package.compile (err, source) ->
	destDir = "#{appDir}/public/scripts/"

	if !directoryExists destDir
		fs.mkdirSync destDir, 0775

	fs.writeFile "#{appDir}/public/scripts/application.js", source, (err) ->
		if (err)
			throw err

		winston.info 'Compiled application.js'

# Express configuration
app = express.createServer()

app.configure ->
	app.use express.bodyParser()
	app.use express.cookieParser()
	app.use stylus.middleware
		src: "#{appDir}/app/views"
		dest: "#{appDir}/public"
		force: true
		compile: (str, path) ->
			return stylus(str)
				.set('filename', path)
				.set('compress', false)
				.set('warn', true)
				.use(nib())

	app.set 'views', "#{appDir}/app/views"
	app.set 'view engine', 'jade'

	app.get '/', (req, res) ->
		options = {}
		options.locals =
			project: "Applied Phlebotinum"
			page_title: "Home"
		res.render 'index', options

	app.get '/game/new', (req, res) ->
		
	
	app.use express.logger()
	app.use express.static "#{appDir}/public"










#common.now = now

engine = require './app/engine'
engine.newGame()

app.listen parseInt(process.env.PORT) || 7777
winston.info 'Listening on ' + app.address().port

now = require 'now'

everyone = now.initialize app
everyone.now.getWorld = ->
	@now.world = 5
	@now.receiveWorld()

now.on 'connect', ->
	#availableHosts = host for host in hosts when host.notFull()
	# host = availableHosts[Math.floor(Math.random(availableHosts.length))] unless availableHosts.length == 0
	winston.info 'connected: '+@user.clientId
#	host = hosts[0]
#	host.group.addUser @user.clientId
#	@user.world = host.world

now.on 'disconnect', ->
	console.log "Left : " + @now