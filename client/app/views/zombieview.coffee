AvatarView = require('./avatarview').AvatarView

class ZombieView extends AvatarView
	constructor: (@actor, @canvas) ->
		@sprite_file = 'zombie-01-walk'
		super
	
module.exports =
	ZombieView: ZombieView