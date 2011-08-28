class AvatarController
	constructor: (@avatar, @canvas) ->
		@canvas.keyboard.addEvent 'keydown', (event) =>
			switch event.keyCode
				when @canvas.keyboard.ARROW_UP
					event.preventDefault()
					@avatar.move
						y: -10
				when @canvas.keyboard.ARROW_DOWN
					event.preventDefault()	
					@avatar.move
						y: 10
				when @canvas.keyboard.ARROW_LEFT
					event.preventDefault()
					@avatar.move
						x: -10
				when @canvas.keyboard.ARROW_RIGHT
					event.preventDefault()
					@avatar.move
						x: 10
			@avatar.changed.dispatch()

module.exports =
	AvatarController: AvatarController
