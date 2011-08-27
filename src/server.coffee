http = require('http')
nko = require('nko')('ahE2gHoOKLxdrUI0')

app = http.createServer (req, res) ->
	res.writeHead 200
		'Content-Type': 'text/html'
	res.end 'Hello, World'

app.listen parseInt(process.env.PORT) || 7777
console.log 'Listening on ' + app.address().port