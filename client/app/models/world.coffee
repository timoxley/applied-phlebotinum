_ = require 'underscore'

Avatar = require('./avatar').Avatar

try
	Signal = require("../../../lib/signals").Signal
catch err
	Signal = require('signals').Signal


class World
	constructor: ({@id, @height, @width, @avatars}) ->
		@avatars ?= {}
		console.log "new World"
		@avatarAdded = new Signal()
		@avatarRemoved = new Signal()

	# addUser: (client) =>
	# 	console.log 'Adding User'
	# 	

	# 
	# 	@addAvatar new Avatar {userId, x, y}
	# 
	# removeUser: (userId) =>
	# 	@removeAvatar userId

	addAvatar: (avatar) =>
		@avatars[avatar.id] = avatar
		
		x = Math.floor(Math.random() * 60) * 10
		y = Math.floor(Math.random() * 60) * 10
		avatar.x = x
		avatar.y = y
		@avatarAdded.dispatch avatar
		avatar
	removeAvatar: (id) =>
		@avatarRemoved.dispatch @avatars[id]
		@avatars[id].destroy()
		delete @avatars[id]
	serialize: =>
		console.log "@avatars:"
		console.log @avatars
		out =
			avatars: avatar.serialize() for id, avatar of @avatars  
module.exports = {World}
