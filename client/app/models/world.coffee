EventEmitter2 = require('eventemitter2').EventEmitter2

class World extends EventEmitter2
	constructor: (@height, @width) ->
		@avatars = []
	addAvatar: (avatar) =>
		@avatars.push avatar
		@emit 'avatar.added', avatar
		avatar
module.exports =
	World: World
