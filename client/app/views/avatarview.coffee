_ = require 'underscore'

class AvatarView
	constructor: (@actor, @canvas) ->
		
		@actor.changed.add (motion) =>
			@render()
			
		@direction = @actor.DOWN
		unless @sprite_file?
			@sprite_file = 'male-01-walk'
		@render()
		
	render: (motion) =>
		
		if @actor.me and not @ellipse? and @displayElement
			@ellipse = @canvas.display.ellipse
				origin:
					x: 'center'
					y: -18
				radius_x: 20
				radius_y: 8
				fill: "rgba(100, 255, 100, 0.2)"
				stroke: "1px rgba(100, 255, 100, 0.3)"
			@canvas.removeChild @displayElement
			@canvas.addChild @ellipse
			@canvas.addChild @displayElement
		if @ellipse?
			@ellipse.x = @actor.x
			@ellipse.y = @actor.y

		if not @displayElement?
			@displayElement = @canvas.display.sprite
				origin:
					x: 'center'
					y: 'center'
				image: '/images/sprites/' + @sprite_file + '.png'
				generate: true
				width: 40
				offset_x: 0
				height: 40
				offset_y: 40
				direction: 'x'
				duration: 200
				
			@displayElement.x = @actor.x
			@displayElement.y = @actor.y
			
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
