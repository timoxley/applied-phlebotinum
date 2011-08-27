class WorldView
	constructor: (@world, @el) ->
		console.log "WorldView Created"
		canvas = oCanvas.create
			canvas: @el
		
		rectangle = canvas.display.rectangle
			x: 77,
			y: 77,
			width: 200,
			height: 100,
			fill: "#0aa"
		
		canvas.addChild rectangle
		
module.exports =
	WorldView: WorldView
