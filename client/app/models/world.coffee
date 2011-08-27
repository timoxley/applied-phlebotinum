
try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@height, @width, @avatars}) ->
		console.log @avatars
		@avatars ?= []
		console.log "new World"
		@avatarAdded = new Signal()
		
	addAvatar: (avatar) =>
		@avatars.push avatar
		@avatarAdded.dispatch avatar
		avatar
	removeAvatar: (avatar) =>
		@avatars.push avatar
		@avatarAdded.dispatch avatar
		avatar
module.exports =
	World: World
