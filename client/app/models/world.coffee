_ = require 'underscore'

Avatar = require('./avatar').Avatar

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@id, @height, @width, avatars}) ->
		@avatarAdded = new Signal()
		@avatarRemoved = new Signal()
		@avatarMoved = new Signal()

		@avatars = {}
		console.log avatars
		if avatars?
			(console.log avatar) for id, avatar of avatars
			(@addAvatar new Avatar(avatar)) for id, avatar of avatars
		else
			
		console.log "new World"
		console.log @avatars


	addAvatar: (avatar) =>
		console.log @
		@avatars[avatar.id] = avatar
		@avatarAdded.dispatch avatar
		avatar
	removeAvatar: (id) =>
		@avatarRemoved.dispatch @avatars[id]
		@avatars[id].destroy()
		delete @avatars[id]

	moveAvatar: (id, x, y) =>
		avatar = @avatars[id]
		@avatarMoved.dispatch avatar

	serialize: =>
		console.log "@avatars:"
		console.log @avatars
		out =
			width: @width
			height: @height
			avatars: (avatar.serialize()) for id, avatar of @avatars  
module.exports = {World}
