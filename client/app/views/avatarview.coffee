class AvatarView
	constructor: (@avatar, @canvas) ->
		@avatar.changed.add (motion) =>
			console.log(motion)
			@render(motion)

		@render()
		
	render: (motion) =>
		switch motion
			when 'start'
				console.log 'start'
				@displayElement.start()
			when 'stop'
				console.log 'stop'
				@displayElement.stop()
		
		if not @displayElement?
			@displayElement = @canvas.display.sprite
				origin: { x: 'center', y: 'center' },
				image: '/images/sprites/male-01-walk.png',
				generate: true,
				width: 20,
				height: 20,
				direction: 'x',
				duration: 200

			@displayElement.x = @avatar.x
			@displayElement.y = @avatar.y
			@displayElement.scale(2, 2)
			@canvas.addChild @displayElement
		else 
			@displayElement.x = @avatar.x
			@displayElement.y = @avatar.y
			@canvas.draw.redraw()
	destroy: =>
		@canvas.removeChild @displayElement
module.exports =
	AvatarView: AvatarView
