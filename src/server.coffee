http = require('http')
nko = require('nko')('ahE2gHoOKLxdrUI0')

_ = require 'underscore'

# allows us to write client-side commonjs modules
stitch = require('stitch')

coffee = require('coffee-script')

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
	paths: ["#{__dirname}/client/app","#{__dirname}/client/app/", path.resolve(require.resolve('eventemitter2'), '..')]

package.compile (err, source) ->
	destDir = "#{__dirname}/public/scripts/"

	if !directoryExists destDir
		fs.mkdirSync destDir, 0775

	fs.writeFile "#{__dirname}/public/scripts/application.js", source, (err) ->
		if (err)
			throw err

		console.log 'Compiled application.js'

# Express configuration
app = express.createServer()

app.configure ->
	app.use express.bodyParser()
	app.use express.cookieParser()
	app.use stylus.middleware
		src: "#{__dirname}/app/views"
		dest: "#{__dirname}/public"
		force: true
		compile: (str, path) ->
			return stylus(str)
				.set('filename', path)
				.set('compress', false)
				.set('warn', true)
				.use(nib())

	app.set 'views', "#{__dirname}/app/views"
	app.set 'view engine', 'jade'

	app.get '/', (req, res) ->
		options = {}
		options.locals =
			project: "Applied Phlebotinum"
			page_title: "Home"
		res.render 'index', options
	app.get '/test', (req, res) ->
		options = {}
		res.send "#{__dirname}/client/app"

	app.use express.logger()
	app.use express.static "#{__dirname}/public"

app.listen parseInt(process.env.PORT) || 7777
console.log 'Listening on ' + app.address().port