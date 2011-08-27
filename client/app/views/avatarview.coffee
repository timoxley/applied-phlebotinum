class AvatarView
	constructor: (@avatar) ->
		console.log "new avatar view"
		

AvatarView.create = (avatar, canvas) ->
	canvas.display.rectangle
		x: Math.random() * 200
		y: Math.random() * 200
		width: 10
		height: 10
		fill: "#333"
		
module.exports =
	AvatarView: AvatarView
