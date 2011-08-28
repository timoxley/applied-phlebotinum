class AvatarView
	constructor: (@avatar, @canvas) ->		
		@avatar.changed.add (motion) =>
			@render(motion)
		@direction = @avatar.DOWN
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
				
			@displayElement.x = @avatar.x
			@displayElement.y = @avatar.y

			if @avatar.me isnt false
				@ellipse = @canvas.display.ellipse
					origin:
						x: 'center'
						y: -9
					radius_x: 15
					radius_y: 6
					fill: "rgba(255, 0, 0, 0.05)"
					stroke: "1px rgba(255, 0, 0, 0.1)"
				@ellipse.x = @avatar.x
				@ellipse.y = @avatar.y
				@canvas.addChild @ellipse
			@canvas.addChild @displayElement


		else
			@displayElement.x = @avatar.x
			@displayElement.y = @avatar.y
			if @ellipse?
				@ellipse.x = @avatar.x
				@ellipse.y = @avatar.y
		if @avatar.isMoving isnt false
			unless @direction == @avatar.direction
				@direction = @avatar.direction
				@displayElement.offset_y = @direction * @displayElement.height
				@displayElement.init()
			@displayElement.start()
		else
			@displayElement.stop()		
	destroy: =>
		@canvas.removeChild @displayElement
module.exports =
	AvatarView: AvatarView
