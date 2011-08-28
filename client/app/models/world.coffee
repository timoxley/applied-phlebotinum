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
		@avatarRemoved = new Signal()

		@sendInitSignals()

	sendInitSignals: =>
		@avatarAdded.dispatch avatar for avatar of @avatars


	addUser: (userId) =>
		@addAvatar new Avatar {userId}

	removeUser: (userId) =>
		@removeAvatar userId

	addAvatar: (avatar) =>
		@avatars[avatar.userId] = avatar
		@avatarAdded.dispatch avatar
	removeAvatar: (userId) =>
		@avatarRemoved.dispatch @avatars[userId]
		@avatars[userId].destroy()
		delete @avatars[userId]
		
module.exports = {World}
