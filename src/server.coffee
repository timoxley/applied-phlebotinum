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

Engine = require('./app/engine').Engine

# utility helper. If dir exists return true
directoryExists = (dir) ->
	try
		fs.statSync dir
		return true
	catch err
		return false

# Stitch configuration
package = stitch.createPackage
	paths: [
		"#{appDir}/client/app"
		"#{appDir}/client/app/"
		"#{appDir}/lib/"
	]

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


engine = new Engine app






app.listen parseInt(process.env.PORT) || 7777
winston.info 'Listening on ' + app.address().port

