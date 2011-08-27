Avatar = require('./avatar').Avatar

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@height, @width, @avatars}) ->
		@avatars ?= []
		console.log "new World"
		@avatarAdded = new Signal()
		@avatarRemoved = new Signal()
		@addAvatar userId for userId in @users

	addUser: (userId) =>
		@addAvatar new Avatar {userId}

	removeUser: (userId) =>
		@removeAvatar userId

	addAvatar: (avatar) =>
		@avatars[avatar.userId] = avatar
		avatarRemoved
	removeAvatar: (userId) =>
		avatarRemoved.dispatch @avatars[userId]
		@avatars[userId].destroy()
		delete @avatars[userId]
		
module.exports =
	World: World
