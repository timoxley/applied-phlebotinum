class AvatarController
	constructor: (@avatar, @canvas) ->
		@canvas.keyboard.addEvent 'keydown', (event) =>
			switch event.keyCode
				when @canvas.keyboard.ARROW_UP
					event.preventDefault()
					@avatar.y -= 10
				when @canvas.keyboard.ARROW_DOWN
					event.preventDefault()	
					@avatar.y += 10
				when @canvas.keyboard.ARROW_LEFT
					event.preventDefault()
					@avatar.x -= 10
				when @canvas.keyboard.ARROW_RIGHT
					event.preventDefault()
					@avatar.x += 10
			@avatar.dirty = true

module.exports =
	AvatarController: AvatarController
