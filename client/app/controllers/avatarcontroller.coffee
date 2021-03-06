class AvatarController
	constructor: (@avatar, @canvas, @avatarView) ->
		@canvas.isKeyDown = (key) =>
			@canvas.keyboard.getKeysDown().indexOf(String(key)) != -1
		@canvas.keyboard.W = 87
		@canvas.keyboard.S = 83
		@canvas.keyboard.A = 65
		@canvas.keyboard.D = 68
		
		step = 180
		@stepSize = @avatar.max_speed * step/1000
		timeout = undefined

		@canvas.setLoop =>
			isDown = false
			if canvas.isKeyDown(@canvas.keyboard.ARROW_UP) or canvas.isKeyDown(@canvas.keyboard.W)
				isDown = true
				avatar.direction = avatar.UP
				avatar.move
					y: -@stepSize
			if canvas.isKeyDown(@canvas.keyboard.ARROW_DOWN) or canvas.isKeyDown(@canvas.keyboard.S)
				isDown = true
				avatar.direction = avatar.DOWN
				avatar.move
					y: @stepSize
			if canvas.isKeyDown(@canvas.keyboard.ARROW_LEFT) or canvas.isKeyDown(@canvas.keyboard.A)
				isDown = true
				avatar.direction = avatar.LEFT
				avatar.move
					x: -@stepSize
			if canvas.isKeyDown(@canvas.keyboard.ARROW_RIGHT) or canvas.isKeyDown(@canvas.keyboard.D)
				isDown = true
				avatar.direction = avatar.RIGHT
				avatar.move
					x: @stepSize
			
			if isDown is false && @avatar.isMoving
				@avatar.stop()
		.start()
		@canvas.keyboard.addEvent 'keyup', (event) =>
			
		@canvas.keyboard.addEvent 'keydown', (event) =>
			switch event.keyCode
				when @canvas.keyboard.ARROW_UP or @canvas.keyboard.W
					event.preventDefault()
					avatar.move
						y: -@stepSize
				when @canvas.keyboard.ARROW_DOWN or @canvas.keyboard.S
					event.preventDefault()
					avatar.move
						y: @stepSize
				when @canvas.keyboard.ARROW_LEFT or @canvas.keyboard.A
					event.preventDefault()
					avatar.move
						x: -@stepSize
				when @canvas.keyboard.ARROW_RIGHT or @canvas.keyboard.D
					event.preventDefault()
					avatar.move
						x: @stepSize

module.exports =
	AvatarController: AvatarController
