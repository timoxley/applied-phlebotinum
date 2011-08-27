spawn = require('child_process').spawn
exec = require('child_process').exec

build = (next) ->
	if next?
		console.log "building ./src..."
		coffee = spawn 'coffee', ['-co', '.', './src']
	else 
		console.log "watching ./src for changes..."
		coffee = spawn 'coffee', ['-cwo', '.', './src']

	coffee.stdout.setEncoding 'utf8'
	coffee.stderr.setEncoding 'utf8'
	coffee.stdout.on 'data', (data) ->
		console.log data
	coffee.stderr.on 'data', (data) ->
		console.log data
	coffee.on 'exit', (code) ->
		console.log 'build complete'
		if code is 0
			console.log(next)
			next?()

task 'build', 'build the application', ->
	build()
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

task 'run', 'run the application locally', ->
	build ->
		console.log "running..."
		nodemon = spawn 'nodemon', ['--coffee', '.']
		nodemon.stdout.setEncoding 'utf8'
		nodemon.stderr.setEncoding 'utf8'
		nodemon.stdout.on 'data', (data) ->
			console.log data
		nodemon.stderr.on 'data', (data) ->
			console.log 'error: '
			console.log data