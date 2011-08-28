class AvatarController
	constructor: (@avatar, @canvas) ->
		step = 1000
		@stepSize = @avatar.max_speed * step/1000
		timeout = undefined
		@canvas.keyboard.addEvent 'keyup', (event) =>
			@avatar.stop()
		@canvas.keyboard.addEvent 'keydown', (event) =>
			switch event.keyCode
				when @canvas.keyboard.ARROW_UP
					event.preventDefault()
					@avatar.move
						y: -@stepSize
				when @canvas.keyboard.ARROW_DOWN
					event.preventDefault()	
					@avatar.move
						y:@stepSize 
				when @canvas.keyboard.ARROW_LEFT
					event.preventDefault()
					@avatar.move
						x: -@stepSize
				when @canvas.keyboard.ARROW_RIGHT
					event.preventDefault()
					@avatar.move
						x: @stepSize

module.exports =
	AvatarController: AvatarController
