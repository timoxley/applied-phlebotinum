class AvatarView
	constructor: (@actor, @canvas) ->		
		@actor.changed.add (motion) =>
			@render(motion)
		@direction = @actor.DOWN
		@render()
		
	render: (motion) =>
		if not @displayElement?
			@displayElement = @canvas.display.sprite
				origin:
					x: 'center'
					y: 'center'
				image: '/images/sprites/male-01-walk.png'
				generate: true
				width: 40
				offset_x: 0
				height: 40
				offset_y: 40
				direction: 'x'
				duration: 200
				
			@displayElement.x = @actor.x
			@displayElement.y = @actor.y

			if @actor.me isnt false
				@ellipse = @canvas.display.ellipse
					origin:
						x: 'center'
						y: -9
					radius_x: 15
					radius_y: 6
					fill: "rgba(255, 0, 0, 0.05)"
					stroke: "1px rgba(255, 0, 0, 0.1)"
				@ellipse.x = @actor.x
				@ellipse.y = @actor.y
				@canvas.addChild @ellipse
			@canvas.addChild @displayElement


		else
			@displayElement.x = @actor.x
			@displayElement.y = @actor.y
			if @ellipse?
				@ellipse.x = @actor.x
				@ellipse.y = @actor.y
		if @actor.isMoving isnt false
			unless @direction == @actor.direction
				@direction = @actor.direction
				@displayElement.offset_y = @direction * @displayElement.height
				@displayElement.init()
			@displayElement.start()
		else
			@displayElement.stop()		
	destroy: =>
		@canvas.removeChild @displayElement

module.exports =
	AvatarView: AvatarView
