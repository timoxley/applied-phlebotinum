class AvatarController
	constructor: (@avatar, @canvas) ->
		@canvas.isKeyDown = (key) =>
			@canvas.keyboard.getKeysDown().indexOf(String(key)) != -1

		@canvas.keyboard.W = 87
		@canvas.keyboard.S = 83
		@canvas.keyboard.A = 65
		@canvas.keyboard.D = 68
		
		step = 30
		@stepSize = @avatar.max_speed * step/1000
		timeout = undefined
		
		@canvas.setLoop =>
			if canvas.isKeyDown(@canvas.keyboard.ARROW_UP) or canvas.isKeyDown(@canvas.keyboard.W)
				avatar.move
					y: -@stepSize
			if canvas.isKeyDown(@canvas.keyboard.ARROW_DOWN) or canvas.isKeyDown(@canvas.keyboard.S)
				avatar.move
					y: @stepSize
			if canvas.isKeyDown(@canvas.keyboard.ARROW_LEFT) or canvas.isKeyDown(@canvas.keyboard.A)
				avatar.move
					x: -@stepSize
			if canvas.isKeyDown(@canvas.keyboard.ARROW_RIGHT) or canvas.isKeyDown(@canvas.keyboard.D)
				avatar.move
					x: @stepSize
		.start()
		@canvas.keyboard.addEvent 'keyup', (event) =>
			@avatar.stop()
		@canvas.keyboard.addEvent 'keydown', (event) =>
			switch event.keyCode
				when @canvas.keyboard.ARROW_UP
					event.preventDefault()
				when @canvas.keyboard.ARROW_DOWN
					event.preventDefault()	
				when @canvas.keyboard.ARROW_LEFT
					event.preventDefault()
				when @canvas.keyboard.ARROW_RIGHT
					event.preventDefault()

module.exports =
	AvatarController: AvatarController
