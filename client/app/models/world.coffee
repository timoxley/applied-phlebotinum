_ = require 'underscore'

Avatar = require('./avatar').Avatar
Zombie = require('./avatar').Zombie

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@id, @height, @width, avatars}) ->
		@avatarAdded = new Signal()
		@avatarRemoved = new Signal()
		@avatarChanged = new Signal()

		@avatars = {}
		if avatars?
			(console.log avatar) for id, avatar of avatars
			(@addAvatar new Avatar(avatar)) for id, avatar of avatars

		@zombies = {}

	addAvatar: (avatar) =>
		@avatars[avatar.id] = avatar
		@avatarAdded.dispatch avatar
		avatar.changed.add =>
			@avatarChanged.dispatch avatar
		avatar.world = @
		avatar
		
	removeAvatar: (id) =>
		@avatarRemoved.dispatch @avatars[id]
		delete @avatars[id]

	addZombie: (zombie) =>

	removeZombie: (zombie) =>


	serialize: =>
		out =
			width: @width
			height: @height
			avatars: (avatar.serialize()) for id, avatar of @avatars  
module.exports = {World}
