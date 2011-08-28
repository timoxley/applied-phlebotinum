class AvatarView
	constructor: (@avatar, @canvas) ->
		@avatar.changed.add =>
			@render()

		@render()
		
	render: =>
		if not @displayElement?
			@displayElement = @canvas.display.rectangle
				x: @avatar.x
				y: @avatar.y
				width: 10
				height: 10
				fill: "#333"
			@canvas.addChild @displayElement
		else 
			@displayElement.x = @avatar.x
			@displayElement.y = @avatar.y
			@canvas.draw.redraw()
module.exports =
	AvatarView: AvatarView
