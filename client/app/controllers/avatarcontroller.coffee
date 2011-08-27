class AvatarController
	constructor: (@avatar, @canvas) ->
		console.log 'new AvatarController'
		console.log @canvas.keyboard
		console.log @avatar
		@canvas.keyboard.addEvent 'keydown', (event) =>
			if event.keyCode is @canvas.keyboard.ARROW_UP
				event.preventDefault()
				@avatar.y -= 10
			if event.keyCode is @canvas.keyboard.ARROW_DOWN
				event.preventDefault()	
				@avatar.y += 10
			if event.keyCode is @canvas.keyboard.ARROW_LEFT
				event.preventDefault()
				@avatar.x -= 10
			if event.keyCode is @canvas.keyboard.ARROW_RIGHT
				event.preventDefault()
				@avatar.x += 10
			console.log @
			@avatar.changed()
module.exports =
	AvatarController: AvatarController
	