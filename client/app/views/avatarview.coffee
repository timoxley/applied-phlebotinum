class AvatarView
	constructor: (@avatar) ->
		console.log "new avatar view"
		
	render: (canvas) =>
		canvas.addChild canvas.display.rectangle
			x: @avatar.x
			y: @avatar.y
			width: 10
			height: 10
			fill: "#333"
		console.log("rendering avatar: ")
		console.log(@avatar.name)
		console.log(@avatar.x)
		console.log(@avatar.y)
module.exports =
	AvatarView: AvatarView
