spawn = require('child_process').spawn
exec = require('child_process').exec

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
task 'push', 'push the application to both repos', ->
	exec 'git push', (error, stdout, stderr) ->
		if (error isnt null)
			console.log error.message
		console.log stdout
		console.log stderr
		console.log 'Pushed to origin'
		exec 'git push joyent master', (error, stdout, stderr) ->
			if (error isnt null)
				console.log error.message
			console.log stdout
			console.log stderr
			console.log 'Pushed to joyent'