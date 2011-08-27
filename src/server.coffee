http = require('http')
nko = require('nko')('ahE2gHoOKLxdrUI0')

express   = require('express')
fs        = require('fs')
path      = require('path')

# view libs
stylus    = require('stylus')
nib       = require('nib')



# Express configuration
app = express.createServer()
app.configure ->
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use stylus.middleware
    src: "#{__dirname}/app/views"
    dest:     "#{__dirname}/public"
    force:   true
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

  app.use express.logger()
  app.use express.static "#{__dirname}/public"

app.listen parseInt(process.env.PORT) || 7777
console.log 'Listening on ' + app.address().port