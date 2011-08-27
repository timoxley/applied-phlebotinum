Avatar = require('./avatar').Avatar

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@height, @width, @users}) ->
		@avatars = {}
		@users ?= []
		console.log "new World"
		@avatarAdded = new Signal()

		@addAvatar userId for userId in @users

	addUser: (userId) =>
		@addAvatar new Avatar {userId}
		@users.push userId

	removeUser: (userId) =>
		@removeAvatar userId
		@users.splice(@users.indexOf(userId), 1)

	addAvatar: (avatar) =>
		@avatars[avatar.userId] = avatar

	removeAvatar: (userId) =>
		delete @avatars[userId]

module.exports =
	World: World
