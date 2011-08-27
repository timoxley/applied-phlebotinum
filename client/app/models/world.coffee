

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: (@height, @width) ->
		console.log "new World"
		
		
		@avatars = []
		@avatarAdded = new Signal()
		console.log @avatarAdded.add
	addAvatar: (avatar) =>
		@avatars.push avatar
		@avatarAdded.dispatch avatar
		avatar
		
module.exports =
	World: World
