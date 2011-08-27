spawn = require('child_process').spawn

task 'build', 'build the application', ->
	console.log "watching ./src for changes..."
	
	coffee = spawn 'coffee', ['-cwo', './lib', './src']
	coffee.stdout.setEncoding 'utf8'
	coffee.stderr.setEncoding 'utf8'
	coffee.stdout.on 'data', (data) ->
		console.log data
	coffee.stderr.on 'data', (data) ->
		console.log 'error: '
		console.log data