_ = require 'underscore'

Avatar = require('./avatar').Avatar

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@height, @width, @avatars}) ->
		@avatars ?= {}
		console.log "new World"
		@avatarAdded = new Signal()
		@avatarRemvoved = new Signal()

	init: =>
		@addAvatar new Avatar avatarBase for avatarBase of @avatars

	addUser: (userId) =>
		@addAvatar new Avatar {userId}

	removeUser: (userId) =>
		@removeAvatar userId

	addAvatar: (avatar) =>
		@avatars[avatar.userId] = avatar
		@avatarAdded.dispatch avatar

	removeAvatar: (userId) =>
		@avatarRemoved.dispatch avatar
		delete @avatars[userId]

module.exports =
	World: World
