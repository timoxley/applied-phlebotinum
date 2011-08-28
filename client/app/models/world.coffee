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

	init: =>
		console.log @avatars
		@addAvatar new Avatar avatarBase for id, avatarBase of @avatars

	addUser: (userId) =>
		console.log 'Adding User'
		x = Math.floor(Math.random() * 60) * 10
		y = Math.floor(Math.random() * 60) * 10

		@addAvatar new Avatar {userId, x, y}

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
