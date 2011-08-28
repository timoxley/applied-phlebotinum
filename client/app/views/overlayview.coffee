class OverlayView
	constructor: (@el) ->
		@canvas = oCanvas.create
			canvas: @el,
			background: "rgba(255,0,0,0.5)"


module.exports =
	OverlayView: OverlayView
